//
//  SettingsRouter.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit

class SettingsRouter: SettingsRouterProtocol {
    
    func navigateToAuthFlow() {
        AppRouter.runAuthFlow()
    }

    static func createSettingsRouterModule() -> UIViewController {
        let SettingsController = SettingsViewController()
        let presenter: SettingsPresenterProtocol & SettingsInteractorOutputProtocol = SettingsPresenter()
        SettingsController.presenter = presenter
        presenter.view = SettingsController
        let interactor: SettingsInteractorInputProtocol = SettingsInteractor()
        interactor.presenter = presenter
        presenter.interactor = interactor
        let router: SettingsRouterProtocol = SettingsRouter()
        presenter.router = router
        return SettingsController
    }
    
}
