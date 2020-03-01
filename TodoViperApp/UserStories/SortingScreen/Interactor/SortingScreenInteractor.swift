//
//  SortingScreenInteractor.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation

class SortingScreenInteractor: SortingScreenInteractorInputProtocol {

    var worker: SettingsWorkerInputProtocol?
    weak var presenter: SortingScreenInteractorOutputProtocol?
    
    func changeSortTo(byKey key: String, withValue value: String) {
        let activeObject = getActiveSortType()
        let isKeyChanged = activeObject.key.rawValue != key.lowercased()
        let isValueChanged = activeObject.value.rawValue != value.lowercased()
        if isKeyChanged || isValueChanged {
            guard let sortKey = SortTypeKey(rawValue: key.lowercased()),
                let sortValue = SortTypeValue(rawValue: value.lowercased()) else {
                    return
            }
            let newSortingObject = SortObject(key: sortKey, value: sortValue)
            worker?.setSortSetting(newSortingObject)
            presenter?.didSortChange()
        }
    }
        
    func getActiveSortType() -> SortObject {
        let settings = worker?.getSortSetting()
        return settings ?? SortObject(key: .dueBy, value: .asc)
    }
    
}
