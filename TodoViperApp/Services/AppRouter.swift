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
        
        if AuthManager.shared.isAuthorized {
            window?.rootViewController = LoginViewController()
        } else {
            let loginController = LoginRouter.createLoginRouterModule()
            window?.rootViewController = UINavigationController(rootViewController: loginController)
        }
        
    }
    
}
