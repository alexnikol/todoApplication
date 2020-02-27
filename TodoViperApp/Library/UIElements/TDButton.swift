//
//  TDButton.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit

final class TDButton: UIButton {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.backgroundColor = Colors.light
        self.layer.cornerRadius = 8.0
        self.setTitleColor(Colors.darkColor, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 25.0, weight: .bold)
    }
    
}
