//
//  SortObject.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 01.03.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation

class SortObject {
    var key: SortTypeKey
    var value: SortTypeValue
    
    init(key: SortTypeKey, value: SortTypeValue) {
        self.key = key
        self.value = value
    }
    
    func getOptions() -> String {
        return "\(key.rawValue) \(value.rawValue)"
    }
    
}
