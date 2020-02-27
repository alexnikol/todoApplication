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
            if let authCredentials = result,
                AuthManager.shared.saveCredentials(authCredentials) {
                self.presenter?.signUpProccessSuccess()
            } else {
                let error = error ?? Text.smthWentWrong.localized
                self.presenter?.signUpProccessFail(error)
            }
        }
    }
    
}
