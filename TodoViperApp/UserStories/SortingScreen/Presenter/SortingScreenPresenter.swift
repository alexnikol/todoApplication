//
//  SortingScreenPresenter.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit

class SortingScreenPresenter: SortingScreenPresenterProtocol {
    
    weak var view: SortingScreenViewProtocol?
    var interactor: SortingScreenInteractorInputProtocol?
    var router: SortingScreenRouterProtocol?
    
    func changeSortTo(byKey key: String, withValue value: String) {
        interactor?.changeSortTo(byKey: key, withValue: value)
    }
        
    func getListOfSortObjects() -> (keys: [String], values: [String]) {
        let keys = SortTypeKey.allCases.map { $0.rawValue.capitalized }
        let values = SortTypeValue.allCases.map { $0.rawValue.uppercased() }
        return (keys: keys, values: values)
    }
    
    func getActiveSortType() -> (key: String, value: String) {
        let settings = interactor?.getActiveSortType()
        let key = settings?.key ?? SortTypeKey.dueBy
        let value = settings?.value ?? SortTypeValue.asc
        return (key: key.rawValue.capitalized,
                value: value.rawValue.uppercased())
    }
    
    func navigateBack() {
        router?.navigateBack(fromView: view as? UIViewController)
    }

}

extension SortingScreenPresenter: SortingScreenInteractorOutputProtocol {
    
    func didSortChange() {
        let notificationName = Notification.Name(NotificationName.RefreshTodos.rawValue)
        NotificationCenter.default.post(name: notificationName, object: nil)
        router?.navigateBack(fromView: view as? UIViewController)
    }
}
