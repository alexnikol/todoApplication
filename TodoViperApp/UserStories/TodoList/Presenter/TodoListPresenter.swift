//
//  TodoListPresenter.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit

class TodoListPresenter: TodoListPresenterProtocol {
    
    weak var view: TodoListViewProtocol?
    var interactor: TodoListInteractorInputProtocol?
    var router: TodoListRouterProtocol?
    private var inNextPageProccess = false
    var isAllDataLoaded = false
    var todos: [Todo] = []
    
    func loadNextPage() {
        guard !inNextPageProccess && !isAllDataLoaded else {
            return
        }
        inNextPageProccess = true
        interactor?.fetchNextPageTodos()
    }
    
    func refreshList() {
        inNextPageProccess = false
        isAllDataLoaded = false
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
    
    func sortingButtonDidTap() {
        router?.navigateToSortingSettings(from: view as? UIViewController)
    }
    
}

extension TodoListPresenter: TodoListInteractorOutputProtocol {
    
    func allPagesLoaded() {
        isAllDataLoaded = true
    }

    func fetchedTodos(_ todos: [Todo], error: String?) {
        inNextPageProccess = false
        if let error = error {
            view?.showErrorMessage(error)
        } else {
            if let pagination = interactor?.paginationMeta, pagination.current > 1 {
                self.todos += todos
                view?.updateNewItems(count: todos.count)
            } else {
                self.todos = todos
                view?.refreshList()
            }
        }
 
    }
    
    func createdTodo(_ todo: Todo?, error: String?) {
        if todo != nil {
            refreshList()
        } else {
            view?.showErrorMessage(error ?? Text.smthWentWrong.localized)
        }
    }
    
    func updatedTodo(_ todo: Todo?, error: String?) {
        if todo != nil {
            refreshList()
        } else {
            view?.showErrorMessage(error ?? Text.smthWentWrong.localized)
        }
    }
    
    func deletedTodo(_ id: Int?, error: String?) {
        if id != nil {
            refreshList()
        } else {
            view?.showErrorMessage(error ?? Text.smthWentWrong.localized)
        }
    }
    
}
