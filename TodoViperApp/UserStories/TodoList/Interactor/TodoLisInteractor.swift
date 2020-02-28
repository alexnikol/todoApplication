//
//  TodoLisInteractor.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation

class TodoLisInteractor: TodoListInteractorInputProtocol {
    
    var worker: TodosWorkerInputProtocol?
    weak var presenter: TodoListInteractorOutputProtocol?
    var paginationMeta: PaginationMeta?
    
    func refreshTodos() {
        paginationMeta = nil
        worker?.fetchTodos(byPage: 0)
    }
    
    func fetchNextPageTodos() {
        var nextPage = 1
        guard let pagination = paginationMeta else {
            worker?.fetchTodos(byPage: nextPage)
            return
        }
        if nextPage > pagination.count {
            return
        }
        nextPage = pagination.current + 1
        worker?.fetchTodos(byPage: nextPage)
    }
    
    func createTodo(_ todo: Todo) {
        worker?.createTodo(todo)
    }
    
    func updateTodo(_ todo: Todo) {
        worker?.updateTodo(todo)
    }
    
    func deleteTodo(byId: Int) {
        worker?.deleteTodo(byId: byId)
    }
    
}

extension TodoLisInteractor: TodosWorkerOutputProtocol {
    
    func fetchedTodos(_ todos: TodosPage?, error: String?) {
        guard let page = todos else {
            presenter?.fetchedTodos([], error: error)
            return
        }
        presenter?.fetchedTodos(page.tasks, error: error)
    }
    
    func createdTodo(_ todo: Todo?, error: String?) {
        presenter?.createdTodo(todo, error: error)
    }
    
    func updatedTodo(_ todo: Todo?, error: String?) {
        presenter?.updatedTodo(todo, error: error)
    }
    
    func deletedTodo(_ id: Int?, error: String?) {
        presenter?.deletedTodo(id, error: error)
    }
    
}
