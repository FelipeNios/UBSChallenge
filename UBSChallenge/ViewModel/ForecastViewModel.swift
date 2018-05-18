//
//  ForecastViewModel.swift
//  UBSChallenge
//
//  Created by Felipe Nunez on 5/18/18.
//  Copyright © 2018 FelipeNunez. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ForecastViewModel : NSObject {
    var forecast:BehaviorRelay<[ForecastDataSource]> = BehaviorRelay(value: [])
    var city:BehaviorRelay<City> = BehaviorRelay(value: City())
    var isDataLoading:BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var disposeBag = DisposeBag()
    
    private var latittude:Double = 0
    private var longitude:Double = 0
    
    /**
     Request the channels from the network
     */
    private func fetchData() {
        isDataLoading.accept(true)
        NetworkServiceManager.forecast(lat: latittude, lon: longitude).subscribe { [unowned self] (event) in
            switch event {
            case .next(let channels):
                let items = self.getForecastDataSource(response: channels.list)
                self.forecast.accept(items)
                self.city.accept(channels.city)
            case .error(let error):
                // Catch location failed error on the network call
                debugPrint(error.localizedDescription)
                break
            case .completed:
                self.isDataLoading.accept(false)
            }
            }.disposed(by: disposeBag)
    }
    
    func getForecast() {
        isDataLoading.accept(true)
        LocationManager.shared.updateLocation { [unowned self] (location, error) in
            self.isDataLoading.accept(false)
            if let error = error {
                debugPrint(error.localizedDescription)
                switch error {
                case LocationManagerError.locationFailed:
                    // Catch location failed error
                    break
                case LocationManagerError.noPermission:
                    // Catch location failed error due no permissions
                    break
                default:
                    break
                }
            } else if let location = location {
                self.latittude = location.coordinate.latitude
                self.longitude = location.coordinate.longitude
                self.fetchData()
            } else {
                debugPrint("Unexpected error happened")
                // Catch unknown error
            }
        }
    }
    
    func getForecastDataSource(response:[ForecastItem]) -> [ForecastDataSource] {
        var dict: [String:[ForecastItem]] = [:]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        
        for item in response {
            let key = dateFormatter.string(from: item.datetime)
            if case nil = dict[key]?.append(item) { dict[key] = [item] }
        }
        return dict.map { ForecastDataSource(date: $0.key, list: $0.value) }
    }
}
