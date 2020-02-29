//
//  TodosEndpoint.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 28.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation
import Alamofire

enum TodosEndpoint {
    case fetchTodos(page: Int)
    case createTodo(_ todo: Todo)
    case updateTodo(_ todo: Todo)
    case deleteTodo(_ id: Int)
}

extension TodosEndpoint: EndPointType {
    
    var baseURL: URL? {
        return URL(string: environmentBaseURL)
    }
    
    var path: String {
        switch self {
        case .fetchTodos:
            return "tasks"
        case .createTodo:
            return "tasks"
        case .updateTodo(let todo):
            return "tasks/\(todo.id)"
        case .deleteTodo(let id):
            return "tasks/\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .fetchTodos:
            return .get
        case .createTodo:
            return .post
        case .updateTodo:
            return .put
        case .deleteTodo:
            return .delete
        }
    }
    
    var options: [String: Any]? {
        let encoder = JSONEncoder()
        switch self {
        case .fetchTodos:
            return [:]
        case .createTodo(let todo):
            let data = try? encoder.encode(todo)
            return try? JSONSerialization.jsonObject(with: data ?? Data()) as? [String: Any]
        case .updateTodo(let todo):
            let data = try? encoder.encode(todo)
            return try? JSONSerialization.jsonObject(with: data ?? Data()) as? [String: Any]
        case .deleteTodo:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .fetchTodos:
            return URLEncoding.default
        case .createTodo:
            return JSONEncoding.default
        case .updateTodo:
            return JSONEncoding.default
        case .deleteTodo:
            return JSONEncoding.default
        }
    }
    
}
