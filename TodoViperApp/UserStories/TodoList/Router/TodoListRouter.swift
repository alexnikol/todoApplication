//
//  TodoListRouter.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit

class TodoListRouter: TodoListRouterProtocol {
    
    func navigateToAuthApp() {
        DispatchQueue.main.async {
            AppRouter.runAuthFlow()
        }
    }
    
    static func createTodoListRouterModule() -> UIViewController {
        let todosWorker: TodosWorkerInputProtocol = TodosWorker()
        let TodoListController = TodoListViewController()
        let presenter: TodoListPresenterProtocol & TodoListInteractorOutputProtocol = TodoListPresenter()
        TodoListController.presenter = presenter
        presenter.view = TodoListController
        let interactor: TodoListInteractorInputProtocol & TodosWorkerOutputProtocol = TodoLisInteractor()
        interactor.presenter = presenter
        todosWorker.interactor = interactor
        interactor.worker = todosWorker
        presenter.interactor = interactor
        let router: TodoListRouterProtocol = TodoListRouter()
        presenter.router = router
        return TodoListController
    }
    
}
