//
//  TodoListProtocols.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation

protocol TodoListViewProtocol: class {

    var presenter: TodoListPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func refreshList()
    func showErrorMessage(_ message: String)
}

protocol TodoListPresenterProtocol: class {
    
    var view: TodoListViewProtocol? { get set }
    var interactor: TodoListInteractorInputProtocol? { get set }
    var router: TodoListRouterProtocol? { get set }
    var todos: [Todo] { get }
    
    // VIEW -> PRESENTER
    func refreshList()
    func loadNextPage()
    func createTodo(_ todo: Todo)
    func updateTodo(_ todo: Todo)
    func deleteTodo(byId: Int)
}

protocol TodoListInteractorInputProtocol: class {
    
    var presenter: TodoListInteractorOutputProtocol? { get set }
    var worker: TodosWorkerInputProtocol? { get set }
    var paginationMeta: PaginationMeta? { get set }
    
    // PRESENTER -> INTERACTOR
    func refreshTodos()
    func fetchNextPageTodos()
    func createTodo(_ todo: Todo)
    func updateTodo(_ todo: Todo)
    func deleteTodo(byId: Int)
}

protocol TodoListInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
    func fetchedTodos(_ todos: [Todo], error: String?)
    func createdTodo(_ todo: Todo?, error: String?)
    func updatedTodo(_ todo: Todo?, error: String?)
    func deletedTodo(_ id: Int?, error: String?)
}

protocol TodoListRouterProtocol: class {

    // PRESENTER -> ROUTER
}
