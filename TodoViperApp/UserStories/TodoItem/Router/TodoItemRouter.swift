//
//  TodoItemRouter.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit

class TodoItemRouter: TodoItemRouterProtocol {
    
    func navigateBackToTodosList(from view: UIViewController?) {
        view?.navigationController?.popViewController(animated: true)
    }
    
    static func createTodoItemRouterModule(forTodo todo: Todo?) -> UIViewController {
        let todosWorker: TodosWorkerInputProtocol = TodosWorker()
        let TodoItemController = TodoItemViewController()
        let presenter: TodoItemPresenterProtocol & TodoItemInteractorOutputProtocol = TodoItemPresenter()
        TodoItemController.presenter = presenter
        presenter.view = TodoItemController
        let interactor: TodoItemInteractorInputProtocol & TodosWorkerOutputProtocol = TodoItemInteractor()
        interactor.presenter = presenter
        interactor.todo = todo
        todosWorker.interactor = interactor
        interactor.worker = todosWorker
        presenter.interactor = interactor
        let router: TodoItemRouterProtocol = TodoItemRouter()
        presenter.router = router
        return TodoItemController
    }
    
}
