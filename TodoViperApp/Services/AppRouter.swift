//
//  AppRouter.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit

final class AppRouter {
    
    static func runOnLoadFlow() {
        if AuthManager.shared.isAuthorized {
            AppRouter.runMainAppFlow()
        } else {
            AppRouter.runAuthFlow()
        }
    }
    
    static func runMainAppFlow() {
        let window = UIApplication.shared.keyWindow
        let controller = TodoListRouter.createTodoListRouterModule()
        window?.rootViewController = UINavigationController(rootViewController: controller)
        runFadeAnimationForWindow(window)
    }
    
    static func runAuthFlow() {
        let window = UIApplication.shared.keyWindow
        let loginController = LoginRouter.createLoginRouterModule()
        window?.rootViewController = UINavigationController(rootViewController: loginController)
        runFadeAnimationForWindow(window)
    }
    
    static private func runFadeAnimationForWindow(_ window: UIWindow?) {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.5
        UIView.transition(with: window, duration: duration,
                          options: options, animations: {},
                          completion: { _ in })
    }
    
}
