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
    
    func createTodo(_ todo: Todo) {}
    
    func updateTodo(_ todo: Todo) {}
    
    func deleteTodo(byId: Int) {}
    
}
