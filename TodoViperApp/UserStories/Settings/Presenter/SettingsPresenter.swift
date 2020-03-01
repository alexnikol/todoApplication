//
//  SettingsPresenter.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit

class SettingsPresenter: SettingsPresenterProtocol {
   
    weak var view: SettingsViewProtocol?
    var interactor: SettingsInteractorInputProtocol?
    var router: SettingsRouterProtocol?
    
    func logout() {
        interactor?.logout()
    }

    func openSortSettings() {
        router?.navigateToSortSettings(view: view as? UIViewController)
    }
    
    func getActiveSettings() -> String {
        let result = interactor?.getActiveSettings() ?? SortObject(key: .dueBy, value: .asc)
        let keyString = result.key.rawValue.capitalized
        let valueString = result.value.rawValue.uppercased()
        return "Property - \(keyString), Order - \(valueString)"
    }

}

extension SettingsPresenter: SettingsInteractorOutputProtocol {
    
    func didLogout() {
        router?.navigateToAuthFlow()
    }
    
}
