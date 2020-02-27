//
//  AuthResponse.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation

struct AuthResponse: Decodable {
    
    let accessToken: String
    let done: Bool
    
    enum ResultCodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case done
    }
    
    init(from decoder: Decoder) throws {
        let objectsContainer = try decoder.container(keyedBy: ResultCodingKeys.self)
        done = try objectsContainer.decode(Bool.self, forKey: .done)
        accessToken = try objectsContainer.decode(String.self, forKey: .accessToken)
    }
    
}
