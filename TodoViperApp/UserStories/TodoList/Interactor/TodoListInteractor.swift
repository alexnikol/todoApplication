//
//  TodoLisInteractor.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation

class TodoListInteractor: TodoListInteractorInputProtocol {
  
    var settingsWorker: SettingsWorkerInputProtocol?
    var todosWorker: TodosWorkerInputProtocol?
    weak var presenter: TodoListInteractorOutputProtocol?
    var paginationMeta: PaginationMeta?
    
    var currentSort: SortObject {
        return settingsWorker?.getSortSetting()
            ?? SortObject(key: .dueBy, value: .asc)
    }
    
    func refreshTodos() {
        paginationMeta = nil
        todosWorker?.fetchTodos(byPage: 0, withSort: currentSort)
    }
    
    func fetchNextPageTodos() {
        var nextPage = 1
        guard let pagination = paginationMeta else {
            todosWorker?.fetchTodos(byPage: nextPage, withSort: currentSort)
            return
        }
        if nextPage > pagination.count {
            return
        }
        nextPage = pagination.current + 1
        todosWorker?.fetchTodos(byPage: nextPage, withSort: currentSort)
    }
    
    func createTodo(_ todo: Todo) {
        todosWorker?.createTodo(todo)
    }
    
    func updateTodo(_ todo: Todo) {
        todosWorker?.updateTodo(todo)
    }
    
    func deleteTodo(byId: Int) {
        todosWorker?.deleteTodo(byId: byId)
    }

}

extension TodoListInteractor: TodosWorkerOutputProtocol {
    
    func createdTodo(_ todo: Todo?, error: String?) {}
    
    func updatedTodo(_ todo: Todo?, error: String?) {}
    
    func fetchedTodos(_ todos: TodosPage?, error: String?) {
        guard let page = todos else {
            presenter?.fetchedTodos([], error: error)
            return
        }
        presenter?.fetchedTodos(page.tasks, error: error)
    }
    
    func deletedTodo(_ id: Int?, error: String?) {
        presenter?.deletedTodo(id, error: error)
    }
    
}
