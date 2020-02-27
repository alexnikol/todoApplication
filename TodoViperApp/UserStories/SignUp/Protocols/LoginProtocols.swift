//
//  LoginProtocols.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation

protocol LoginViewProtocol: class {

    var presenter: LoginPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showAlert(with message: String)
    func invalidateUserField()
    func invalidatePasswordField()
}

protocol LoginPresenterProtocol: class {
    
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    var router: LoginRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func loginWith(userName: String, password: String)
    func navigateToSignUpViewController()
}

protocol LoginInteractorInputProtocol: class {
    
    var presenter: LoginInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func signUpWith(userName: String, password: String)
}

protocol LoginInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
    
}

protocol LoginRouterProtocol: class {

    // PRESENTER -> ROUTER
    func navigateToSignUpViewController(from view: LoginViewProtocol)
}
