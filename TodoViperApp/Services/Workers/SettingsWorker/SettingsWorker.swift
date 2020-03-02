//
//  SettingsWorker.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 01.03.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation

class SettingsWorker: SettingsWorkerInputProtocol {
    
    func getSortSetting() -> SortObject {
        guard let sortValueString = UserDefaults.standard.string(forKey: "sortValue"),
            let sortValue = SortTypeValue(rawValue: sortValueString),
            let sortKeyString = UserDefaults.standard.string(forKey: "sortKey"),
            let sortKey = SortTypeKey(rawValue: sortKeyString) else {
                return SortObject(key: .dueby, value: .asc)
        }
        return SortObject(key: sortKey, value: sortValue)
    }
    
    func setSortSetting(_ sort: SortObject) {
        UserDefaults.standard.set(sort.value.rawValue, forKey: "sortValue")
        UserDefaults.standard.set(sort.key.rawValue, forKey: "sortKey")
    }
    
}
