//
//  AuthManager.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation
import SimpleKeychain

final class AuthManager {
    
    static let shared = AuthManager()
    
    var isAuthorized: Bool {
        return A0SimpleKeychain().string(forKey: AuthKeys.token.rawValue) != nil
    }
    
    enum AuthKeys: String {
        case token = "auth_token"
    }
    
    private init() {}
    
    internal func clearAuthCredentials() {
        _ = A0SimpleKeychain().deleteEntry(forKey: AuthKeys.token.rawValue)
    }
    
    func saveCredentials(_ credentials: AuthResponse) -> Bool {
        let isTokenSet = A0SimpleKeychain().setString(credentials.accessToken,
                                                      forKey: AuthKeys.token.rawValue)
        return isTokenSet
    }
    
    func logout() {
        clearAuthCredentials()
    }
    
    func token() -> String {
        return A0SimpleKeychain().string(forKey: AuthKeys.token.rawValue) ?? ""
    }
    
}
