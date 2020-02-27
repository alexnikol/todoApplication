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
            if let authCredentials = result,
                AuthManager.shared.saveCredentials(authCredentials) {
                self.presenter?.loginProccessSuccess()
            } else {
                let error = error ?? Text.smthWentWrong.localized
                self.presenter?.loginProccessFail(error)
            }
        }
    }
    
}
