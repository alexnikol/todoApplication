//
//  BaseController.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol Loaderable: UIViewController {
    func showLoader()
    func hideLoader()
}

extension Loaderable {
    
    func showLoader() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func hideLoader() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
}

class BaseController: UIViewController, Loaderable {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
    }
        
}
