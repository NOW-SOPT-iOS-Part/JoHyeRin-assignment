//
//  UserTargetType.swift
//  34th-Sopt-Assignment
//
//  Created by 조혜린 on 5/7/24.
//

import Foundation

import Moya


enum BoxOfficeTargetType {
    case getDailyBoxOffice(targetDate: String)
}

extension BoxOfficeTargetType: TargetType {
    var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getDailyBoxOffice:
            return "/boxoffice/searchDailyBoxOfficeList.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getDailyBoxOffice:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getDailyBoxOffice(targetDate: let date):
            return .requestParameters(parameters: ["key" : Config.apiKey, "targetDt" : date], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return .none
    }
}
