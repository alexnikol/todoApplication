//
//  NetworkSettingsManager.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation

class NetworkSettingsManager {
    
    private static var sharedNetworkManager: NetworkSettingsManager = {
        let networkManager = NetworkSettingsManager()
        return networkManager
    }()
    
    private init() {}
    
    class func shared() -> NetworkSettingsManager {
        return sharedNetworkManager
    }
    
    static func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299:
            return .success
        case 422:
            return .success
        case 400...500:
            return .failure(NetworkResponse.serviceUnaccessible.error())
        case 501...599:
            return .failure(NetworkResponse.serviceUnaccessible.error())
        case 600:
            return .failure(NetworkResponse.outdated.error())
        default:
            return .failure(NetworkResponse.failed.error())
        }
    }
    
}
