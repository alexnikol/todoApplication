//
//  SortingScreenViewController.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD

final class SettingsViewController: BaseController {
    
    private let contentView = UIView()
    private var sortSettings: UILabel!
    var presenter: SettingsPresenterProtocol?
    
    override func loadView() {
        contentView.backgroundColor = Colors.white
        view = contentView
    }
    
    deinit {
        let notificationName = Notification.Name(NotificationName.SortChanged.rawValue)
        NotificationCenter.default.removeObserver(self, name: notificationName, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        setupView()
        let notificationName = Notification.Name(NotificationName.SortChanged.rawValue)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.updateSortInfo),
                                               name: notificationName,
                                               object: nil)
    }
    
    @objc
    private func updateSortInfo() {
        let text = presenter?.getActiveSettings() ?? ""
        sortSettings.text = """
                            \(Text.Sorting.localized):
                            \(text)
                            """
    }
    
    private func setupView() {
        navigationItem.title = Text.settingsTitle.localized
        sortSettings = UILabel()
        updateSortInfo()
        sortSettings.textColor = Colors.darkColor
        sortSettings.numberOfLines = 0
        let logout = UIButton(type: .system)
        logout.setTitle(Text.Logout.localized, for: .normal)
        logout.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
        let editSorting = UIButton(type: .system)
        editSorting.setTitle(Text.editSortingTitle.localized, for: .normal)
        editSorting.addTarget(self, action: #selector(openSortingSettings),
                              for: .touchUpInside)
        self.view.addSubview(sortSettings)
        self.view.addSubview(editSorting)
        self.view.addSubview(logout)
        
        sortSettings.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.topMargin).offset(20.0)
            make.leading.equalTo(view.snp.leading).offset(40.0)
            make.trailing.equalTo(view.snp.trailing).offset(-40.0)
            make.height.equalTo(60.0)
        }
        
        editSorting.snp.makeConstraints { (make) in
            make.top.equalTo(sortSettings.snp.bottom).offset(20.0)
            make.leading.equalTo(view.snp.leading).offset(40.0)
            make.trailing.equalTo(view.snp.trailing).offset(-40.0)
            make.height.equalTo(80.0)
        }
                
        logout.snp.makeConstraints { (make) in
            make.top.equalTo(editSorting.snp.bottom).offset(30.0)
            make.leading.equalTo(view.snp.leading).offset(40.0)
            make.trailing.equalTo(view.snp.trailing).offset(-40.0)
            make.height.equalTo(24.0)
            make.bottom.greaterThanOrEqualTo(view.snp.bottom).offset(40.0).priority(750.0)
        }
    }
        
    @objc
    private func didTapLogout() {
        openApprovalController()
    }
    
    @objc
    private func openSortingSettings() {
        presenter?.openSortSettings()
    }

    private func openApprovalController() {
        let alert = UIAlertController(title: nil, message: nil,
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Text.Cancel.localized, style: .cancel))
        alert.addAction(UIAlertAction(title: Text.Logout.localized, style: .destructive) { _ in
            self.presenter?.logout()
        })
        if #available(iOS 13.0, *) {
            alert.overrideUserInterfaceStyle = .light
        }
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension SettingsViewController: SettingsViewProtocol {}
