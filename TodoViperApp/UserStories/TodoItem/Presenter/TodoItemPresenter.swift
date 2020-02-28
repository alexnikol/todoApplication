//
//  TodoItemPresenter.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit

class TodoItemPresenter: TodoItemPresenterProtocol {

    weak var view: TodoItemViewProtocol?
    var interactor: TodoItemInteractorInputProtocol?
    var router: TodoItemRouterProtocol?
    
    func createTodo(text: String, priority: Todo.Priority, dueBy: Int) {
        interactor?.createTodo(text: text, priority: priority, dueBy: dueBy)
    }
    
    func updateTodo(text: String, priority: Todo.Priority, dueBy: Int) {
        interactor?.updateTodo(text: text, priority: priority, dueBy: dueBy)
    }
    
    func deleteTodo() {
        interactor?.deleteTodo()
    }
    
    func prioritiesList() -> [String] {
        return Todo.Priority.allCases.map { $0.rawValue }
    }
    
}

extension TodoItemPresenter: TodoItemInteractorOutputProtocol {
    
    func createdTodo() {
        view?.successfullyCreated()
    }
    
    func updatedTodo() {
        view?.successfullyUpdated()
    }
    
    func deletedTodo() {
        view?.successfullyDeleted()
    }
    
    func proccessFailed(error: String?) {
        view?.showErrorMessage(error ?? Text.smthWentWrong.localized)
    }

}
