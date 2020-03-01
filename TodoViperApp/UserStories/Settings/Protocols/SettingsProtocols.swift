//
//  SettingsProtocols.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 28.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit

protocol SettingsViewProtocol: class {

    var presenter: SettingsPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func sortSuccessfullyChanged()
}

protocol SettingsPresenterProtocol: class {
    
    var view: SettingsViewProtocol? { get set }
    var interactor: SettingsInteractorInputProtocol? { get set }
    var router: SettingsRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func logout()
    func changeSortTo(_ sort: String)
}

protocol SettingsInteractorInputProtocol: class {
    
    var presenter: SettingsInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func logout()
    func changeSortTo(_ sort: String)
}

protocol SettingsInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
    func didLogout()
    func didSortChange()
}

protocol SettingsRouterProtocol: class {

    // PRESENTER -> ROUTER
    func navigateToAuthFlow()
}
