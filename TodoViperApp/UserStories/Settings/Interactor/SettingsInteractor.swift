//
//  SettingsInteractor.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation

class SettingsInteractor: SettingsInteractorInputProtocol {
        
    var worker: TodosWorkerInputProtocol?
    weak var presenter: SettingsInteractorOutputProtocol?
    
    func logout() {
        AuthManager.shared.logout()
        presenter?.didLogout()
    }
    
    func changeSortTo(_ sort: String) {
        presenter?.didSortChange()
    }
    
}
