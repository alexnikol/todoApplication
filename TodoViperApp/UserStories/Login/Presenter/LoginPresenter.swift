//
//  LoginPresenter.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit

class LoginPresenter: LoginPresenterProtocol {
    
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?
    var router: LoginRouterProtocol?
    
    func loginWith(userName: String, password: String) {
        let result = validateForm(userName: userName, password: password)
        if result.isValid {
            interactor?.loginWith(userName: userName, password: password)
        } else {
            view?.showAlert(with: result.error ?? Text.smthWentWrong.localized)
        }
    }
    
    func navigateToSignUpViewController() {
        guard let view = view else {
            return
        }
        router?.navigateToSignUpViewController(from: view)
    }
    
    private func validateForm(userName: String, password: String) -> (isValid: Bool, error: String?) {
        var result: (isValid: Bool, error: String?) = (isValid: false, error: nil)
        let isUserValid = userName != ""
        let isPasswordValid = password != ""
        
        if !isUserValid {
            view?.invalidateUserField()
            result.error = Text.userNameInvalid.localized
        } else if !Validator.isValidEmail(userName) {
            view?.invalidateUserField()
            result.error = Text.invalidEmail.localized
        }
        if !isPasswordValid {
            view?.invalidatePasswordField()
            if isUserValid {
                result.error = Text.passwordInvalid.localized
            }
        }
        result.isValid = isUserValid && Validator.isValidEmail(userName) && isPasswordValid
        return result
    }
    
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    
    func loginProccessSuccess() {
        router?.navigateToMainApp()
    }
    
    func loginProccessFail(_ error: String) {
        view?.showAlert(with: error)
    }
    
}
