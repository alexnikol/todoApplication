//
//  TodoItemViewController.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD

final class TodoItemViewController: BaseController, UITextViewDelegate {
    
    private let contentView = UIView()
    private let alert = UILabel()
    private var textView: TDTextView!
    private var segmentView: UISegmentedControl!
    private var dateField: TDField!
    var presenter: TodoItemPresenterProtocol?
        
    override func loadView() {
        contentView.backgroundColor = Colors.white
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = presenter?.getTitle()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        setupView()
        presenter?.updateForm()
    }
    
    private func setupView() {
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self,
                                  action: #selector(saveTapped))
        let delete = UIBarButtonItem(barButtonSystemItem: .trash, target: self,
                                     action: #selector(deleteTapped))
        navigationItem.rightBarButtonItems = [save, delete]
        alert.textColor = Colors.dangerColor
        alert.numberOfLines = 0
        textView = getTextView()
        textView.delegate = self
        segmentView = getPriorityControll()
        dateField = getScheduleField()
        self.view.addSubview(alert)
        self.view.addSubview(textView)
        self.view.addSubview(segmentView)
        self.view.addSubview(dateField)
        
        alert.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.topMargin).offset(10.0)
            make.leading.equalTo(view.snp.leading).offset(40.0)
            make.trailing.equalTo(view.snp.trailing).offset(-40.0)
            make.height.equalTo(20.0)
        }
        
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(alert.snp.bottom).offset(10.0)
            make.leading.equalTo(self.view.snp.leading).offset(40.0)
            make.trailing.equalTo(self.view.snp.trailing).offset(-40.0)
            make.height.equalTo(80.0)
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
            make.bottom.greaterThanOrEqualTo(view.snp.bottom).offset(40.0).priority(750)
        }
        
    }
    
    @objc
    private func saveTapped() {
        showLoader()
        let time = ((dateField.inputView as? UIDatePicker)?.date ?? Date()).timeIntervalSince1970
        presenter?.saveTodo(text: textView.text ?? "",
                            priority: segmentView.selectedSegmentIndex,
                            dueBy: Int(time))
    }
    
    @objc
    private func deleteTapped() {
        presenter?.deleteTodo()
    }
    
    private func getTextView() -> TDTextView {
        let control = TDTextView()
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
        let now = Date()
        let datePicker = UIDatePicker()
        datePicker.minimumDate = now
        datePicker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        control.inputView = datePicker
        control.text = Date.getStringFromDate(now)
        return control
    }
    
    @objc
    private func timeChanged(_ sender: UIDatePicker) {
        dateField.text = Date.getStringFromDate(sender.date)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let view = textView as? TDTextView
        view?.setToValid()
        alert.text = ""
    }
    
}

extension TodoItemViewController: TodoItemViewProtocol {
    
    func setFormData(text: String, priorityIndex: Int, dueBy: Int) {
        textView.text = text
        segmentView.selectedSegmentIndex = priorityIndex
        let date = Date(timeIntervalSince1970: TimeInterval(dueBy))
        dateField.text = Date.getStringFromDate(date)
        (dateField.inputView as? UIDatePicker)?.date = date
    }
    
    func successProccess() {
        hideLoader()
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.text
        loadingNotification.label.text = Text.success.localized
    }
        
    func showErrorMessage(_ message: String) {
        alert.text = message
        hideLoader()
    }
    
    func invalidateMessageField() {
        textView.setToInvalid()
    }
    
}
