//
//  EndPointType.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation
import Alamofire

protocol EndPointType {
    var baseURL: URL? { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var options: [String: Any]? { get }
    var encoding: ParameterEncoding { get }
}

extension EndPointType {
    
    var environmentBaseURL: String {
        return ConfigurationValues.get().baseURL
    }
    
    var requestPath: URL? {
        guard let requestPath = self.baseURL?.appendingPathComponent(path) else {
            return nil
        }
        return requestPath
    }
        
}
