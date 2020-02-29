//
//  UITextView+Extensions.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 29.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit

extension UITextView {
    
    func addCancelToolbar() {
        let numberToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: Text.done.localized,
                            style: .plain, target: self, action: #selector(cancelNumberPad))
        ]
        numberToolbar.sizeToFit()
        self.inputAccessoryView = numberToolbar
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(cancelNumberPad))
        swipeDown.direction = .down
        numberToolbar.addGestureRecognizer(swipeDown)
    }

    @objc
    func cancelNumberPad() {
        self.endEditing(true)
    }
    
}
