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
    
    func saveTodo(text: String, priority: Int, dueBy: Int) {
        let validation = validateTodo(text: text, priority: priority, dueBy: dueBy)
        if validation.isValid {
            interactor?.saveTodo(text: text, priority: priority, dueBy: dueBy)
        } else {
            view?.invalidateMessageField()
            view?.showErrorMessage(validation.error ?? Text.smthWentWrong.localized)
        }
    }
        
    func deleteTodo() {
        interactor?.deleteTodo()
    }
    
    func prioritiesList() -> [String] {
        return interactor?.prioritiesList() ?? []
    }
    
    func getTitle() -> String {
        return interactor?.getTitle() ?? ""
    }
    
    func updateForm() {
        if let todo = interactor?.getModifiedTodo() {
            self.view?.setFormData(text: todo.title,
                                   priorityIndex: todo.priority.order(),
                                   dueBy: todo.dueBy)
        }
    }
    
    private func validateTodo(text: String, priority: Int, dueBy: Int) -> (isValid: Bool, error: String?) {
        var result: (isValid: Bool, error: String?) = (false, nil)
        if text == "" {
            result.error = Text.invalidMessage.localized
        } else {
            result.isValid = true
        }
        return result
    }
    
}

extension TodoItemPresenter: TodoItemInteractorOutputProtocol {
    
    func createdTodo() {
        successProccess()
    }
    
    func updatedTodo() {
        successProccess()
    }
    
    func deletedTodo() {
        successProccess()
    }
    
    func proccessFailed(error: String?) {
        view?.showErrorMessage(error ?? Text.smthWentWrong.localized)
    }
    
    private func successProccess() {
        self.view?.successProccess()
        let notificationName = Notification.Name(NotificationName.RefreshTodos.rawValue)
        NotificationCenter.default.post(name: notificationName, object: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.router?.navigateBackToTodosList(from: self.view as? UIViewController)
        }
    }

}
