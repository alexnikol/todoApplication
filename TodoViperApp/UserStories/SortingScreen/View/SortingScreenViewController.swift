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

final class SortingScreenViewController: BaseController {
    
    private let contentView = UIView()
    var sortByField: SelectField!
    var sortAs: SelectField!
    var presenter: SortingScreenPresenterProtocol?
    
    override func loadView() {
        contentView.backgroundColor = Colors.white
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        setupView()
        updateSettings()
    }
    
    @objc
    private func saveTapped() {
        let key = sortByField.text ?? ""
        let value = sortAs.text ?? ""
        presenter?.changeSortTo(byKey: key, withValue: value)
    }
    
    @objc
    private func closeTapped() {
        presenter?.navigateBack()
    }
    
    private func updateSettings() {
        
        guard let activeData = presenter?.getActiveSortType() else {
            return
        }
        
        updateSettings(key: activeData.key, value: activeData.value)
        
    }
    
    private func setupView() {
        navigationItem.title = Text.Sorting.localized
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self,
                                  action: #selector(saveTapped))
        let close = UIBarButtonItem(barButtonSystemItem: .cancel, target: self,
                                     action: #selector(closeTapped))
        navigationItem.rightBarButtonItems = [save]
        navigationItem.leftBarButtonItems = [close]
        
        guard let data = presenter?.getListOfSortObjects() else {
            return
        }
        
        sortByField = getSelectView(options: data.keys)
        sortAs = getSelectView(options: data.values)
        
        self.view.addSubview(sortByField)
        self.view.addSubview(sortAs)
        
        sortByField.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.topMargin).offset(20.0)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(300.0)
            make.height.equalTo(40.0)
        }
        
        sortAs.snp.makeConstraints { (make) in
            make.top.equalTo(sortByField.snp.bottom).offset(10.0)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(300.0)
            make.height.equalTo(40.0)
        }
        
    }
    
    func getSelectView(options: [String]) -> SelectField {
        let field = SelectField()
        field.addOptions(options)
        return field
    }
    
}

extension SortingScreenViewController: SortingScreenViewProtocol {
    
    func updateSettings(key: String, value: String) {
        sortByField.setActiveOption(key)
        sortAs.setActiveOption(value)
    }
    
}
