//
//  TodoItemViewController.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit
import SnapKit

final class TodoItemViewController: BaseController {
    
    private let contentView = UIView()
    private var textView: UIView!
    private var segmentView: UISegmentedControl!
    private var dateField: TDField!
    var presenter: TodoItemPresenterProtocol?
        
    override func loadView() {
        contentView.backgroundColor = Colors.backgroundColor
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        setupView()
        navigationItem.title = Text.todos.localized
//        showLoader()
    }
    
    private func setupView() {
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self,
                                  action: #selector(saveTapped))
        navigationItem.rightBarButtonItems = [save]
        textView = getTextView()
        segmentView = getPriorityControll()
        dateField = getScheduleField()
        self.view.addSubview(textView)
        self.view.addSubview(segmentView)
        self.view.addSubview(dateField)
        textView.backgroundColor = UIColor.red
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.topMargin).offset(20.0)
            make.leading.equalTo(self.view.snp.leading).offset(40.0)
            make.trailing.equalTo(self.view.snp.trailing).offset(-40.0)
            make.height.lessThanOrEqualTo(80.0)
        }

        segmentView.snp.makeConstraints { (make) in
            make.top.equalTo(textView.snp.bottom).offset(20.0)
            make.leading.equalTo(view.snp.leading).offset(40.0)
            make.trailing.equalTo(view.snp.trailing).offset(-40.0)
            make.height.equalTo(24.0)
        }

        dateField.snp.makeConstraints { (make) in
            make.top.equalTo(segmentView.snp.bottom).offset(20.0)
            make.leading.equalTo(view.snp.leading).offset(40.0)
            make.trailing.equalTo(view.snp.trailing).offset(-40.0)
            make.height.equalTo(40.0)
            make.bottom.greaterThanOrEqualToSuperview().priority(750.0)
        }
        
    }
    
    @objc
    private func saveTapped() {}
    
    private func getTextView() -> UIView {
        let control = UIView()
        control.backgroundColor = Colors.darkColor.withAlphaComponent(0.25)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }
    
    private func getPriorityControll() -> UISegmentedControl {
        let items = self.presenter?.prioritiesList()
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 1
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }
    
    private func getScheduleField() -> TDField {
        let control = TDField()
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }
    
}

extension TodoItemViewController: TodoItemViewProtocol {
    
    func successfullyCreated() {}
    
    func successfullyUpdated() {}
    
    func successfullyDeleted() {}
    
    func refreshList() {
        hideLoader()
    }
        
    func showErrorMessage(_ message: String) {
        print("ERROR \(message)")
        hideLoader()
    }
    
}
