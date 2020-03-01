//
//  TodosWorkerProtocols.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 28.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation

protocol TodosWorkerInputProtocol: class {
    var interactor: TodosWorkerOutputProtocol? { get set }
    func fetchTodos(byPage: Int, withSort: SortObject)
    func createTodo(_ todo: Todo)
    func updateTodo(_ todo: Todo)
    func deleteTodo(byId: Int)
}

protocol TodosWorkerOutputProtocol: class {
    func fetchedTodos(_ todos: TodosPage?, error: String?)
    func createdTodo(_ todo: Todo?, error: String?)
    func updatedTodo(_ todo: Todo?, error: String?)
    func deletedTodo(_ id: Int?, error: String?)
}
