//
//  SettingsViewController.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit
import SnapKit

final class SettingsViewController: UITableViewController, Loaderable {
    
    var presenter: SettingsPresenterProtocol?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        setupView()
    }
    
    private func setupView() {
        navigationItem.title = Text.settingsTitle.localized
        tableView.register(UINib(nibName: CellName.LogoutCell.rawValue, bundle: nil),
                           forCellReuseIdentifier: CellName.LogoutCell.rawValue)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellName.SortChangeCell.rawValue)
    }
    
    private func openApprovalController() {
        let alert = UIAlertController(title: nil, message: nil,
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Text.Cancel.localized, style: .cancel))
        alert.addAction(UIAlertAction(title: Text.Logout.localized, style: .destructive) { _ in
            self.presenter?.logout()
        })
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension SettingsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: CellName.SortChangeCell.rawValue)
            cell.textLabel?.text = "Sort"
            cell.accessoryType = .disclosureIndicator
        } else if indexPath.row == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: CellName.LogoutCell.rawValue)
            cell.accessoryType = .none
            
            (cell  as? LogoutCell)?.logoutProccess = { [weak self] in
                self?.openApprovalController()
            }
            
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            print("OPEN SELECT VIEW")
        }
    }
    
}

extension SettingsViewController: SettingsViewProtocol {
    
    func sortSuccessfullyChanged() {
        print("successProccess")
    }
    
}
