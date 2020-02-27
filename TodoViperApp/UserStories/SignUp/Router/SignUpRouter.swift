//
//  SignUpRouter.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit

class SignUpRouter: SignUpRouterProtocol {
    
    func navigateToMainApp() {
        DispatchQueue.main.async {
            AppRouter.runMainAppFlow()
        }
    }
    
    func navigateToLoginViewController(from view: SignUpViewProtocol) {
        guard let viewController = view as? UIViewController else {
            return
        }
        let controller = UIViewController()
        controller.view.backgroundColor = Colors.blue
        viewController.navigationController?.pushViewController(controller, animated: true)
    }
    
    static func createSignUpRouterModule() -> UIViewController {
        let signUpController = SignUpViewController()
        let presenter: SignUpPresenterProtocol & SignUpInteractorOutputProtocol = SignUpPresenter()
        signUpController.presenter = presenter
        presenter.view = signUpController
        let interactor: SignUpInteractorInputProtocol = SignUpInteractor()
        interactor.presenter = presenter
        presenter.interactor = interactor
        let router: SignUpRouterProtocol = SignUpRouter()
        presenter.router = router
        return signUpController
    }
    
}
