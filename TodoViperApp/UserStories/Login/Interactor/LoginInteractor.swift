//
//  LoginInteractor.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation

class LoginInteractor: LoginInteractorInputProtocol {
    
    private let networkManager = NetworkManager()
    weak var presenter: LoginInteractorOutputProtocol?
    
    func loginWith(userName: String, password: String) {
        let request = AuthEndpoint.login(username: userName, password: password)
        networkManager.fetch(endPoint: request, responseType: AuthResponse.self) { (result, error) in
            if let authCredentials = result, let token = authCredentials.token,
                AuthManager.shared.saveCredentials(token) {
                self.presenter?.loginProccessSuccess()
            } else if let result = result,
               (!result.emailErrors.isEmpty || !result.passwordErrors.isEmpty) {
               let errors = result.emailErrors + result.passwordErrors
                let validationError = errors.joined(separator: ", ")
               self.presenter?.loginProccessFail(String(validationError))
           } else {
               let error = error ?? Text.smthWentWrong.localized
               self.presenter?.loginProccessFail(error)
           }
        }
    }
    
}
