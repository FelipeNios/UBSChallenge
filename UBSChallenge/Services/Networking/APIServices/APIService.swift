//
//  APIService.swift
//  UBSChallenge
//
//  Created by Felipe Nunez on 5/18/18.
//  Copyright © 2018 FelipeNunez. All rights reserved.
//

import Moya

enum ApiService {
    case forecast(lat:Double, lon:Double)
}

/**
 Network layer, this using Moya, separates the network layer from the App layer
 */
extension ApiService : TargetType {
    var apiKey:String {
        return "650d44c430d5f4105ed1724b03d7f5c5"
    }
    
    var baseURL: URL {
        let url = "http://api.openweathermap.org/data/2.5"
        return URL(string: url)!
    }
    
    var path: String {
        switch self {
        case .forecast:
            return "/forecast"
        }
    }
    
    var task : Task {
        switch self {
        case .forecast(let lat, let lon):
            var parameters:[String:Any] = [:]
            parameters["lat"] = "\(lat)"
            parameters["lon"] = "\(lon)"
            parameters["appid"] = apiKey
            parameters["units"] = "imperial"
            return Task.requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var sampleData: Data {
        return Data()
    }
}

