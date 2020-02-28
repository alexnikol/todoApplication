//
//  AuthResponse.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation

class AuthResponse: Decodable {
    let token: String?
    let message: String?
    let emailErrors: [String]
    let passwordErrors: [String]
    
    private enum ResultCodingKeys: String, CodingKey {
        case token
        case message
        case fields
    }
    
    private enum Errors: String, CodingKey {
        case email
        case password
    }
    
    required init(from decoder: Decoder) throws {
        let objectsContainer = try decoder.container(keyedBy: ResultCodingKeys.self)
        token = try objectsContainer.decodeIfPresent(String.self, forKey: .token)
        message = try objectsContainer.decodeIfPresent(String.self, forKey: .message)
        guard let coordinatesContainer = try? objectsContainer.nestedContainer(keyedBy: Errors.self,
                                                                               forKey: .fields) else {
                emailErrors = []
                passwordErrors = []
                return
        }
        
        emailErrors = try coordinatesContainer.decodeIfPresent([String].self, forKey: .email) ?? []
        passwordErrors = try coordinatesContainer.decodeIfPresent([String].self, forKey: .password) ?? []
    }
    
}
