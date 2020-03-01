//
//  SettingsInteractor.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation

class SettingsInteractor: SettingsInteractorInputProtocol {
    
    var worker: SettingsWorkerInputProtocol?
    weak var presenter: SettingsInteractorOutputProtocol?
    
    func logout() {
        AuthManager.shared.logout()
        presenter?.didLogout()
    }
    
    init(worker: SettingsWorkerInputProtocol) {
        self.worker = worker
    }
    
    func getActiveSettings() -> SortObject {
        let settings = worker?.getSortSetting()
        return settings ?? SortObject(key: .dueBy, value: .asc)
    }
     
}
