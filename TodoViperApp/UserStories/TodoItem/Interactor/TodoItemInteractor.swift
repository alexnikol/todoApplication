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
    
    func saveTodo(text: String, priority: Int, dueBy: Int) {
        let priority = prioritiesList()[priority]
        guard let priorityItem = Todo.Priority(rawValue: priority) else {
            return
        }
        let id = todo?.id ?? 0
        let modifiedTodo = Todo(id: id, title: text, dueBy: dueBy, priority: priorityItem)
        print("modifiedTodo \(modifiedTodo)")
        if todo != nil {
            worker?.updateTodo(modifiedTodo)
        } else {
            worker?.createTodo(modifiedTodo)
        }
    }
    
    func deleteTodo() {
        guard let todoID = todo?.id else {
            return
        }
        worker?.deleteTodo(byId: todoID)
    }
    
    func prioritiesList() -> [String] {
        return Todo.Priority.allCases.map { $0.rawValue }
    }
    
    func getTitle() -> String {
        return todo == nil ? Text.createTitle.localized : Text.editTitle.localized
    }
    
    func getModifiedTodo() -> Todo? {
        return todo
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
