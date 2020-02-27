//
//  SignUpProtocols.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation

protocol SignUpViewProtocol: class {

    var presenter: SignUpPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showAlert(with message: String)
    func invalidateUserField()
    func invalidatePasswordField()
}

protocol SignUpPresenterProtocol: class {
    
    var view: SignUpViewProtocol? { get set }
    var interactor: SignUpInteractorInputProtocol? { get set }
    var router: SignUpRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func signUpWith(userName: String, password: String)
    func navigateToLoginViewController()
}

protocol SignUpInteractorInputProtocol: class {
    
    var presenter: SignUpInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func signUpWith(userName: String, password: String)
}

protocol SignUpInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
    func signUpProccessSuccess()
    func signUpProccessFail(_ error: String)
}

protocol SignUpRouterProtocol: class {

    // PRESENTER -> ROUTER
    func navigateToLoginViewController(from view: SignUpViewProtocol)
    func navigateToMainApp()
}
