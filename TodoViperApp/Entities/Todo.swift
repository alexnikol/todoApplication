//
//  Todo.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 28.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation

struct Todo: Decodable {
    
    let id: Int
    let title: String
    let dueBy: Int
    let priority: Priority
    
    enum Priority: String, Decodable {
        case low = "Low"
        case normal = "Normal"
        case high = "High"
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
    
}
