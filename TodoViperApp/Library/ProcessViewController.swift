//
//  ProcessViewController.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit
import MBProgressHUD

class ProcessViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        let spinningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        spinningActivity.label.text = "Loading"
        print(Text.testString.localized)
    }
    
    private func setupView() {
        view.backgroundColor = Colors.backgroundColor
    }
    
}
