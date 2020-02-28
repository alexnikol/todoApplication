//
//  Date+Extensions.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 28.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import Foundation

extension Date {
    
    static func getTimeFromTS(timestamp: Int) -> String {
       let formatter = DateFormatter()
       formatter.dateFormat = "MM/dd/yyyy h:mma"
       formatter.timeZone = TimeZone.current
       let time = Date(timeIntervalSince1970: TimeInterval(timestamp))
       return formatter.string(from: time)
    }
    
}
