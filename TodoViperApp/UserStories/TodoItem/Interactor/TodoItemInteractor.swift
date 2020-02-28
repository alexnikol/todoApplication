//
//  TodoItemInteractor.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation

class TodoItemInteractor: TodoItemInteractorInputProtocol {
 
    var worker: TodosWorkerInputProtocol?
    weak var presenter: TodoItemInteractorOutputProtocol?
    var todo: Todo?
    
    func createTodo(text: String, priority: Todo.Priority, dueBy: Int) {
        let todo = Todo(id: 0, title: text, dueBy: dueBy, priority: priority)
        worker?.createTodo(todo)
    }
    
    func updateTodo(text: String, priority: Todo.Priority, dueBy: Int) {
        guard let todoID = todo?.id else {
            return
        }
        let todo = Todo(id: todoID, title: text, dueBy: dueBy, priority: priority)
        worker?.updateTodo(todo)
    }
    
    func deleteTodo() {
        guard let todoID = todo?.id else {
            return
        }
        worker?.deleteTodo(byId: todoID)
    }
    
}

extension TodoItemInteractor: TodosWorkerOutputProtocol {
    
    func fetchedTodos(_ todos: TodosPage?, error: String?) {}
    
    func createdTodo(_ todo: Todo?, error: String?) {
        presenter?.createdTodo()
    }
    
    func updatedTodo(_ todo: Todo?, error: String?) {
        presenter?.updatedTodo()
    }
    
    func deletedTodo(_ id: Int?, error: String?) {
        presenter?.deletedTodo()
    }
    
}
