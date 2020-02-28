//
//  Localizable.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation

protocol Localizable {
    var localized: String { get }
}

enum Text: String, Localizable {
    
    case done
    case userName
    case password
    case login
    case signUp
    case go
    case toSignUpFlow
    case userNameInvalid
    case passwordInvalid
    case smthWentWrong
    case invalidEmail
    case todos
    case deadline
    case sort
    case todosTitle
    case settingsTitle
    case delete
    case edit
    
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
    
}
