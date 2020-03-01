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
       
    func changeSortTo(_ sort: String) {
        interactor?.changeSortTo(sort)
    }

}

extension SettingsPresenter: SettingsInteractorOutputProtocol {
    
    func didLogout() {
        router?.navigateToAuthFlow()
    }
    
    func didSortChange() {
        view?.sortSuccessfullyChanged()
    }
    
}
