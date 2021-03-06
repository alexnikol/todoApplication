//
//  Todo.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 28.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation

struct Todo: Codable {
    
    let id: Int
    let title: String
    let dueBy: Int
    let priority: Priority
    
    enum Priority: String, Codable, CaseIterable {
        case low = "Low"
        case normal = "Normal"
        case high = "High"
        
        func order() -> Int {
            switch self {
            case .high:
                return 2
            case .normal:
                return 1
            case .low:
                return 0
            }
        }
        
    }
    
    private enum ResultCodingKeys: String, CodingKey {
        case id, title, dueBy, priority
    }
    
    init(from decoder: Decoder) throws {
        let objectsContainer = try decoder.container(keyedBy: ResultCodingKeys.self)
        id = try objectsContainer.decode(Int.self, forKey: .id)
        title = try objectsContainer.decode(String.self, forKey: .title)
        dueBy = try objectsContainer.decode(Int.self, forKey: .dueBy)
        priority = try objectsContainer.decode(Priority.self, forKey: .priority)
    }
    
    init(id: Int, title: String, dueBy: Int, priority: Priority) {
        self.id = id
        self.title = title
        self.dueBy = dueBy
        self.priority = priority
    }
    
}
