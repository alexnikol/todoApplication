//
//  SortingScreenRouter.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit

class SortingScreenRouter: SortingScreenRouterProtocol {
    
    func navigateBack(fromView view: UIViewController?) {
        view?.dismiss(animated: true, completion: nil)
    }

    static func createSortingScreenRouterModule() -> UIViewController {
        let worker: SettingsWorkerInputProtocol = SettingsWorker()
        let SortingScreenController = SortingScreenViewController()
        let presenter: SortingScreenPresenterProtocol & SortingScreenInteractorOutputProtocol = SortingScreenPresenter()
        SortingScreenController.presenter = presenter
        presenter.view = SortingScreenController
        let interactor: SortingScreenInteractorInputProtocol = SortingScreenInteractor()
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.interactor = interactor
        let router: SortingScreenRouterProtocol = SortingScreenRouter()
        presenter.router = router
        return SortingScreenController
    }
    
}
