//
//  LoginRouter.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit

class LoginRouter: LoginRouterProtocol {
    
    func navigateToSignUpViewController(from view: LoginViewProtocol) {
        guard let viewController = view as? UIViewController else {
            return
        }
        viewController.navigationController?.pushViewController(ProcessViewController(),
                                                                animated: true)
    }
    
    static func createLoginRouterModule() -> UIViewController {
        let loginController = LoginViewController()
        let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter()
        loginController.presenter = presenter
        presenter.view = loginController
        let interactor: LoginInteractorInputProtocol = LoginInteractor()
        interactor.presenter = presenter
        presenter.interactor = interactor
        let router: LoginRouterProtocol = LoginRouter()
        presenter.router = router
        return loginController
    }
    
}
