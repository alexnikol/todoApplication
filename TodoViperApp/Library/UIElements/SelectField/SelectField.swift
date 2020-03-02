//
//  SelectField.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 30.01.2020.
//  Copyright © 2020 Conduent. All rights reserved.
//

import UIKit

class SelectField: UITextField {
    
    weak var labelReference: UIView?
    let picker = SelectPicker()
    let insets = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0, right: 20.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setup() {
        setupSelectPickerView()
        self.layer.borderColor = Colors.darkColor.cgColor
        self.layer.borderWidth = 1.5
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8.0
        self.borderStyle = .roundedRect
        self.backgroundColor = Colors.darkColor.withAlphaComponent(0.25)
        self.textColor = Colors.darkColor
        self.addCancelToolbar()
    }

    private func setupSelectPickerView() {
        picker.eventDelegate = self
        picker.delegate = picker
        picker.dataSource = picker
        self.inputView = picker
        if #available(iOS 13.0, *) {
            picker.overrideUserInterfaceStyle = .light
        }
    }
    
    // MARK: - Set new options array method
    func addOptions(_ options: [String]) {
        picker.addList(options)
    }
    
    // MARK: - Set active option
    func setActiveOption(_ option: String) {
        picker.setActiveOption(option)
    }
        
    func setInsets(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let size = CGSize(width: 12.0, height: 6.0)
        return CGRect(x: self.frame.size.width - size.width, y: 0.0,
                      width: size.width, height: self.frame.height)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return setInsets(forBounds: bounds)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return setInsets(forBounds: bounds)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return setInsets(forBounds: bounds)
    }
    
}

extension SelectField: SelectPickerProtocol {
    
    func didSelectRow(option: String) {
        self.text = option
        self.sendActions(for: .valueChanged)
    }
    
}
