//
//  SortingScreenProtocols.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 28.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit

protocol SortingScreenViewProtocol: class {

    var presenter: SortingScreenPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func updateSettings(key: String, value: String)
}

protocol SortingScreenPresenterProtocol: class {
    
    var view: SortingScreenViewProtocol? { get set }
    var interactor: SortingScreenInteractorInputProtocol? { get set }
    var router: SortingScreenRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func changeSortTo(byKey key: String, withValue value: String)
    func getListOfSortObjects() -> (keys: [String], values: [String])
    func getActiveSortType() -> (key: String, value: String)
    func navigateBack()
}

protocol SortingScreenInteractorInputProtocol: class {
    
    var presenter: SortingScreenInteractorOutputProtocol? { get set }
    var worker: SettingsWorkerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func changeSortTo(byKey key: String, withValue value: String)
    func getActiveSortType() -> SortObject
}

protocol SortingScreenInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
    func didSortChange()
}

protocol SortingScreenRouterProtocol: class {

    // PRESENTER -> ROUTER
    func navigateBack(fromView: UIViewController?)
}
