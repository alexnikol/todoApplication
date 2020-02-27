//
//  AppRouter.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit

final class AppRouter {
    
    static func runFlow() {
        let window = UIApplication.shared.keyWindow
        let proccessViewController = ProcessViewController()
        window?.rootViewController = proccessViewController
    }
    
}
