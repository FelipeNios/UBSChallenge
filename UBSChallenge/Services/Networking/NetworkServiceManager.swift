//
//  NetworkServiceManager.swift
//  UBSChallenge
//
//  Created by Felipe Nunez on 5/18/18.
//  Copyright © 2018 FelipeNunez. All rights reserved.
//

import Foundation
import Moya
import RxSwift

import Foundation

enum NetworkingError : Swift.Error {
    case noData
    case noInternet
    case noSuccessStatusCode
    case unkown
}

class NetworkServiceManager {
    /**
     Gets the 5 day forecast data from the network service
     */
    static func forecast(lat:Double, lon:Double) -> Observable<ForecastResponse> {
        guard ReachabilityManager.shared.isOnline else { return Observable.error(NetworkingError.noInternet) }
        
        return Observable.create { observable in
            let provider = MoyaProvider<ApiService>()
            let request = provider.rx.request(.forecast(lat:lat, lon:lon))
                .filterSuccessfulStatusCodes()
                .map(ForecastResponse.self)
            
            let disposable = request.subscribe { event in
                switch event {
                case .success(let result):
                    if result.cod == "200" {
                        observable.onNext(result)
                    } else {
                        observable.onError(NetworkingError.noSuccessStatusCode)
                    }
                case .error(let error):
                    observable.onError(error)
                }
                observable.onCompleted()
            }
            return Disposables.create {
                disposable.dispose()
            }
        }
    }
}
