//
//  TodosWorker.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 28.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation

class TodosWorker: TodosWorkerInputProtocol {
    
    private let networkManager = NetworkManager()
    weak var interactor: TodosWorkerOutputProtocol?
    
    func fetchTodos(byPage: Int) {
        guard let client = interactor else {
            return
        }
        let endPoint = TodosEndpoint.fetchTodos(page: byPage)
        networkManager.fetch(endPoint: endPoint,
                             responseType: TodosPage.self,
                             completion: client.fetchedTodos)
    }
    
    func createTodo(_ todo: Todo) {
        guard let client = interactor else {
            return
        }
        let endPoint = TodosEndpoint.createTodo(todo)
        networkManager.fetch(endPoint: endPoint,
                             responseType: Todo.self,
                             completion: client.createdTodo)
    }
    
    func updateTodo(_ todo: Todo) {
        guard let client = interactor else {
            return
        }
        let endPoint = TodosEndpoint.updateTodo(todo)
        networkManager.fetch(endPoint: endPoint,
                             responseType: Todo.self,
                             completion: client.updatedTodo)
    }
    
    func deleteTodo(byId: Int) {
        guard let client = interactor else {
            return
        }
        let endPoint = TodosEndpoint.deleteTodo(byId)
        networkManager.fetch(endPoint: endPoint,
                             responseType: [String].self) { result, error in
                                if result != nil {
                                   client.deletedTodo(byId, error: error)
                                } else {
                                    client.deletedTodo(nil, error: error)
                                }
        }
    }
    
}
