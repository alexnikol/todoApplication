//
//  TodoListProtocols.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit

protocol TodoListViewProtocol: class {

    var presenter: TodoListPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func refreshList()
    func updateNewItems(count: Int)
    func showErrorMessage(_ message: String)
}

protocol TodoListPresenterProtocol: class {
    
    var view: TodoListViewProtocol? { get set }
    var interactor: TodoListInteractorInputProtocol? { get set }
    var router: TodoListRouterProtocol? { get set }
    var todos: [Todo] { get }
    var isAllDataLoaded: Bool { get set }
    
    // VIEW -> PRESENTER
    func refreshList()
    func loadNextPage()
    func createTodo()
    func updateTodo(_ todo: Todo)
    func deleteTodo(byId: Int)
    func sortingButtonDidTap()
}

protocol TodoListInteractorInputProtocol: class {
    
    var presenter: TodoListInteractorOutputProtocol? { get set }
    var todosWorker: TodosWorkerInputProtocol? { get set }
    var settingsWorker: SettingsWorkerInputProtocol? { get set }
    var paginationMeta: PaginationMeta? { get set }
    
    // PRESENTER -> INTERACTOR
    func refreshTodos()
    func fetchNextPageTodos()
    func deleteTodo(byId: Int)
}

protocol TodoListInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
    func fetchedTodos(_ todos: [Todo], error: String?)
    func deletedTodo(_ id: Int?, error: String?)
    func allPagesLoaded()
}

protocol TodoListRouterProtocol: class {

    // PRESENTER -> ROUTER
    func navigateToSortingSettings(from view: UIViewController?)
    func navigateToTodoItemCreateScreen(from view: UIViewController?)
    func navigateToTodoItemEditScreen(from view: UIViewController?, withTodo: Todo)
}
