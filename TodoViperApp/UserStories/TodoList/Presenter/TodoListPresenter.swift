//
//  TodoListPresenter.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit

class TodoListPresenter: TodoListPresenterProtocol {

    var todos: [Todo] = []
    weak var view: TodoListViewProtocol?
    var interactor: TodoListInteractorInputProtocol?
    var router: TodoListRouterProtocol?
    
    func loadNextPage() {
        interactor?.fetchNextPageTodos()
    }
    
    func refreshList() {
        interactor?.refreshTodos()
    }
    
    func createTodo() {
        router?.navigateToTodoItemCreateScreen(from: view as? UIViewController)
    }
    
    func updateTodo(_ todo: Todo) {
        router?.navigateToTodoItemEditScreen(from: view as? UIViewController, withTodo: todo)
    }
    
    func deleteTodo(byId: Int) {
        interactor?.deleteTodo(byId: byId)
    }
    
}

extension TodoListPresenter: TodoListInteractorOutputProtocol {
    
    func fetchedTodos(_ todos: [Todo], error: String?) {
        
        if let error = error {
            view?.showErrorMessage(error)
        } else {
            self.todos = todos
            view?.refreshList()
        }
 
    }
    
    func createdTodo(_ todo: Todo?, error: String?) {
        if todo != nil {
            interactor?.refreshTodos()
        } else {
            view?.showErrorMessage(error ?? Text.smthWentWrong.localized)
        }
    }
    
    func updatedTodo(_ todo: Todo?, error: String?) {
        if todo != nil {
            interactor?.refreshTodos()
        } else {
            view?.showErrorMessage(error ?? Text.smthWentWrong.localized)
        }
    }
    
    func deletedTodo(_ id: Int?, error: String?) {
        if id != nil {
            interactor?.refreshTodos()
        } else {
            view?.showErrorMessage(error ?? Text.smthWentWrong.localized)
        }
    }
    
}
