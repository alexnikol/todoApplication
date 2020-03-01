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
}

protocol SettingsPresenterProtocol: class {
    
    var view: SettingsViewProtocol? { get set }
    var interactor: SettingsInteractorInputProtocol? { get set }
    var router: SettingsRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func logout()
    func openSortSettings()
    func getActiveSettings() -> String
}

protocol SettingsInteractorInputProtocol: class {
    
    var presenter: SettingsInteractorOutputProtocol? { get set }
    func getActiveSettings() -> SortObject
    // PRESENTER -> INTERACTOR
    func logout()
}

protocol SettingsInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
    func didLogout()
}

protocol SettingsRouterProtocol: class {

    // PRESENTER -> ROUTER
    func navigateToAuthFlow()
    func navigateToSortSettings(view: UIViewController?)

}
