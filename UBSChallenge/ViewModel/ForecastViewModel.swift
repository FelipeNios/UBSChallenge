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
    
    /**
     Request the channels from the network
     */
    func fetchData() {
        isDataLoading.accept(true)
        NetworkServiceManager.forecast(lat: 33.756, lon: -84.392).subscribe { [unowned self] (event) in
            switch event {
            case .next(let channels):
                let items = self.getForecastDataSource(response: channels.list)
                self.forecast.accept(items)
                self.city.accept(channels.city)
            case .error(let error):
                debugPrint(error.localizedDescription)
                break
            case .completed:
                self.isDataLoading.accept(false)
            }
            }.disposed(by: disposeBag)
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
