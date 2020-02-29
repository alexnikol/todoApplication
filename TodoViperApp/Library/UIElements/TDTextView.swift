//
//  TDTextView.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 29.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit

final class TDTextView: UITextView, Validable {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setToValid() {
        self.layer.borderColor = Colors.darkColor.cgColor
    }
    
    func setToInvalid() {
        self.layer.borderColor = Colors.dangerColor.cgColor
    }
    
    private func setup() {
        self.layer.borderColor = Colors.darkColor.cgColor
        self.layer.borderWidth = 1.5
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8.0
        self.backgroundColor = Colors.darkColor.withAlphaComponent(0.25)
        self.textColor = Colors.darkColor
        addCancelToolbar()
    }
    
}
