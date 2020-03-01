//
//  LogoutCell.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 01.03.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit

class LogoutCell: UITableViewCell {
    
    var logoutProccess: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction private func logoutDidTap(_ sender: Any) {
        logoutProccess?()
    }
    
}
