//
//  HomeRoutes.swift
//  BatteryTracker
//
//  Created by Baidetskyi Yurii on 19.05.2025.
//

import Foundation

enum HomeRoutes {
    case sendBatteryInfo(String, SendBatteryInfoRequestDTO)
}

// MARK: Route implementation
extension HomeRoutes: Route {

    // Base URL
    var baseURL: URL {
        switch self {
        case .sendBatteryInfo(let baseUrl, _):
            return URL(string: baseUrl)!
        }
    }
    
    // Path
    var path: String {
        switch self {
        case .sendBatteryInfo:
            "posts"
        }
    }
    
    // Headers
    var httpHeaders: HttpHeaders {
        ["Content-Type": "application/json"]
    }
    
    // Method
    var httpMethod: HttpMethod {
        switch self {
        case .sendBatteryInfo: .post
        }
    }
    
    // Parameters
    var parameters: Parameters? {
        switch self {
        case let .sendBatteryInfo(_, parameters): return parameters.encoded()
        }
    }
    
    // Array Parameters
    var arrayParameters: ArrayParameters? {
        nil
    }
    
    // Encoding type
    var parameterEncoding: ParameterEncoding? {
        return .jsonBase64
    }
}
