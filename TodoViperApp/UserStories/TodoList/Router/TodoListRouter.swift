//
//  TodoListRouter.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit

class TodoListRouter: TodoListRouterProtocol {
    
    func navigateToSortingSettings(from view: UIViewController?) {
        let sortingScreen = SortingScreenRouter.createSortingScreenRouterModule()
        let navigationController = UINavigationController(rootViewController: sortingScreen)
        if #available(iOS 13.0, *) {
            navigationController.overrideUserInterfaceStyle = .light
        }
        view?.present(navigationController, animated: true, completion: nil)
    }
    
    func navigateToTodoItemCreateScreen(from view: UIViewController?) {
        let createController = TodoItemRouter.createTodoItemRouterModule(forTodo: nil)
        createController.hidesBottomBarWhenPushed = true
        view?.navigationController?.pushViewController(createController, animated: true)
    }
    
    func navigateToTodoItemEditScreen(from view: UIViewController?, withTodo: Todo) {
        let editController = TodoItemRouter.createTodoItemRouterModule(forTodo: withTodo)
        editController.hidesBottomBarWhenPushed = true
        view?.navigationController?.pushViewController(editController, animated: true)
    }
    
    static func createTodoListRouterModule() -> UIViewController {
        let todosWorker: TodosWorkerInputProtocol = TodosWorker()
        let settingsWorker: SettingsWorkerInputProtocol = SettingsWorker()
        let TodoListController = TodoListViewController()
        let presenter: TodoListPresenterProtocol & TodoListInteractorOutputProtocol = TodoListPresenter()
        TodoListController.presenter = presenter
        presenter.view = TodoListController
        let interactor: TodoListInteractorInputProtocol & TodosWorkerOutputProtocol = TodoListInteractor()
        interactor.presenter = presenter
        todosWorker.interactor = interactor
        interactor.todosWorker = todosWorker
        interactor.settingsWorker = settingsWorker
        presenter.interactor = interactor
        let router: TodoListRouterProtocol = TodoListRouter()
        presenter.router = router
        return TodoListController
    }
    
}
