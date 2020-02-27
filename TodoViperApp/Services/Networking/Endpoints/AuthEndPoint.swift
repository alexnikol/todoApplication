//
//  AuthEndPoint.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation
import Alamofire

enum AuthEndpoint {
    case login(username: String, password: String)
    case signUp(username: String, password: String)
}

extension AuthEndpoint: EndPointType {
    
    var baseURL: URL? {
        return URL(string: environmentBaseURL)
    }
    
    var path: String {
        switch self {
        case .login:
            return "auth"
        case .signUp:
            return "users"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .signUp:
            return .post
        }
    }
    
    //swiftlint:disable pattern_matching_keywords
    var options: [String: Any]? {
        switch self {
        case .login(let userName, let password):
            let options: [String: Any] = [
                "email": userName,
                "password": password
            ]
            return options
        case .signUp(let userName, let password):
            let options: [String: Any] = [
                "email": userName,
                "password": password
            ]
            return options
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .login:
            return JSONEncoding.default
        case .signUp:
            return JSONEncoding.default
        }
    }
    //swiftlint:enable pattern_matching_keywords
}
