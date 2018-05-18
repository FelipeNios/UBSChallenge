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
    case unkown
}

class NetworkServiceManager {
    /**
     Gets the radio channel data from the network service
     */
    static func forecast(city:String, country:String) -> Observable<[List]> {
        guard ReachabilityManager.shared.isOnline else { return Observable.error(NetworkingError.noInternet) }
        
        return Observable.create { observable in
            let provider = MoyaProvider<ApiService>()
            let request = provider.rx.request(.forecast(city:city, country:country))
                .filterSuccessfulStatusCodes()
                .map(ForecastResponse.self)
            
            let disposable = request.subscribe { event in
                switch event {
                case .success(let result):
                    observable.onNext(result.list)
                    observable.onCompleted()
                case .error(let error):
                    observable.onError(error)
                }
            }
            return Disposables.create {
                disposable.dispose()
            }
        }
    }
}
