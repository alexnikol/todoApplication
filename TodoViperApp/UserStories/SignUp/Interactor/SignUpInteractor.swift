//
//  SignUpInteractor.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation

class SignUpInteractor: SignUpInteractorInputProtocol {
    
    private let networkManager = NetworkManager()
    weak var presenter: SignUpInteractorOutputProtocol?
    
    func signUpWith(userName: String, password: String) {
        let request = AuthEndpoint.signUp(username: userName, password: password)
        networkManager.fetch(endPoint: request, responseType: AuthResponse.self) { (result, error) in
            if let authCredentials = result, let token = authCredentials.token,
                AuthManager.shared.saveCredentials(token) {
                self.presenter?.signUpProccessSuccess()
            } else if let result = result,
                (!result.emailErrors.isEmpty || !result.passwordErrors.isEmpty) {
                let errors = result.emailErrors + result.passwordErrors
                let validationError = errors.joined(separator: ", ")
                self.presenter?.signUpProccessFail(validationError)
            } else {
                let error = error ?? Text.smthWentWrong.localized
                self.presenter?.signUpProccessFail(error)
            }
        }
    }
    
}
