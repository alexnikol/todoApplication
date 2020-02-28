//
//  TodoItemProtocols.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 28.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit

protocol TodoItemViewProtocol: class {

    var presenter: TodoItemPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func successfullyCreated()
    func successfullyUpdated()
    func successfullyDeleted()
    func showErrorMessage(_ message: String)
}

protocol TodoItemPresenterProtocol: class {
    
    var view: TodoItemViewProtocol? { get set }
    var interactor: TodoItemInteractorInputProtocol? { get set }
    var router: TodoItemRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func createTodo(text: String, priority: Todo.Priority, dueBy: Int)
    func updateTodo(text: String, priority: Todo.Priority, dueBy: Int)
    func deleteTodo()
    func prioritiesList() -> [String]
}

protocol TodoItemInteractorInputProtocol: class {
    
    var presenter: TodoItemInteractorOutputProtocol? { get set }
    var worker: TodosWorkerInputProtocol? { get set }
    var todo: Todo? { get set }
    
    // PRESENTER -> INTERACTOR
    func createTodo(text: String, priority: Todo.Priority, dueBy: Int)
    func updateTodo(text: String, priority: Todo.Priority, dueBy: Int)
    func deleteTodo()
}

protocol TodoItemInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
    func createdTodo()
    func updatedTodo()
    func deletedTodo()
    func proccessFailed(error: String?)
}

protocol TodoItemRouterProtocol: class {

    // PRESENTER -> ROUTER
    func navigateBackToTodosList(from view: UIViewController?)
}
