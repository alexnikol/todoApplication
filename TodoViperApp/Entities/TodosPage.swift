//
//  TodosPage.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 28.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation

struct PaginationMeta: Decodable {
    let current: Int
    let limit: Int
    let count: Int
}

class TodosPage: Decodable {
    let tasks: [Todo]
    let meta: PaginationMeta
}
