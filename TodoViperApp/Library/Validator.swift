//
//  Validator.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation

class Validator {
    //swiftlint:disable line_length
    static func isValidEmail(_ text: String) -> Bool {
        let pattern = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let regex = try? NSRegularExpression(pattern: pattern,
                                             options: .caseInsensitive)
        return regex?.firstMatch(in: text, options: [],
                                 range: NSRange(location: 0, length: text.count)) != nil
    }
    //swiftlint:enable line_length
}
