//
//  TodoCell.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 28.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet weak private var message: UILabel!
    @IBOutlet weak private var priority: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func update(message: String, priority: Todo.Priority, dateLabel: String) {
        self.message.text = message
        self.priority.text = priority.rawValue.uppercased()
        self.priority.textColor = getPriorityColor(priority)
        self.dateLabel.text = "\(Text.deadline.localized): \(dateLabel)"
    }
    
    private func getPriorityColor(_ priority: Todo.Priority) -> UIColor {
        switch priority {
        case .high:
            return UIColor.systemRed
        case .normal:
            return UIColor.orange
        case .low:
            return UIColor.darkGray
        }
    }
    
}
