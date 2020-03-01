//
//  SettingsWorkerProtocols.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 28.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation

protocol SettingsWorkerInputProtocol: class {
    func getSortSetting() -> SortObject
    func setSortSetting(_ sort: SortObject)
}
