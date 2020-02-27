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
    case go
    case toSignUpFlow
    case userNameInvalid
    case passwordInvalid
    case smthWentWrong
    case invalidEmail
    
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
    
}
