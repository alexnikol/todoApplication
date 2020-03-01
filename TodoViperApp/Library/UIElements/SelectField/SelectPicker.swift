//
//  SelectPicker.swift
//  TodoViperApp
//
//  Created by Александр Николайчук on 30.01.2020.
//  Copyright © 2020 Conduent. All rights reserved.
//

import UIKit

protocol SelectPickerProtocol: class {
    func didSelectRow(option: String)
}

class SelectPicker: UIPickerView {
    weak var eventDelegate: SelectPickerProtocol?
    private var options: [String] = []
    
    func addList(_ options: [String]) {
        self.options = options
        self.reloadComponent(0)
        let initialValue: String? = !options.isEmpty ? options[0] : nil
        if let firstValue = initialValue {
            eventDelegate?.didSelectRow(option: firstValue)
        }
    }
    
    func setActiveOption(_ option: String) {
        let index = options.firstIndex { (item) -> Bool in
            item == option
        }
        if let existingIndex = index {
            self.selectRow(existingIndex, inComponent: 0, animated: true)
            eventDelegate?.didSelectRow(option: option)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SelectPicker: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if !options.isEmpty {
            self.eventDelegate?.didSelectRow(option: options[row])
        }
    }
}
