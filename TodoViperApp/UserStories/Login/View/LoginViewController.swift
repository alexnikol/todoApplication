//
//  LoginViewController.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit
import SnapKit

final class LoginViewController: BaseController {
    
    private let contentView = UIView()
    private let alert = UILabel()
    private var loginField: TDField!
    private var passwordField: TDField!
    var presenter: LoginPresenterProtocol?
    
    override func loadView() {
        contentView.backgroundColor = Colors.backgroundColor
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        navigationItem.title = Text.login.localized
    }
    
    @objc
    private func toSignUpProcess() {
        presenter?.navigateToSignUpViewController()
    }
    
    @objc
    private func loginProccess() {
        showLoader()
        presenter?.loginWith(userName: loginField.text ?? "",
                             password: passwordField.text ?? "")
    }
    
    @objc
    private func editingDidBegin() {
        loginField.setToValid()
        passwordField.setToValid()
        alert.text = ""
    }
    
    private func setupView() {
        
        alert.textColor = Colors.dangerColor
        alert.numberOfLines = 0
        let form = getLoginForm()
        let link = UIButton(type: .system)
        link.setTitle(Text.toSignUpFlow.localized, for: .normal)
        let toSignUpProcess = UITapGestureRecognizer(target: self,
                                                     action: #selector(self.toSignUpProcess))
        link.addGestureRecognizer(toSignUpProcess)
        let loginButton = TDButton(type: .system)
        loginButton.setTitle(Text.go.localized, for: .normal)
        let loginProcess = UITapGestureRecognizer(target: self,
                                                  action: #selector(self.loginProccess))
        loginButton.addGestureRecognizer(loginProcess)
        self.view.addSubview(alert)
        self.view.addSubview(form)
        self.view.addSubview(link)
        self.view.addSubview(loginButton)
        
        alert.snp.makeConstraints { (make) in
            make.topMargin.equalTo(view.snp.topMargin).offset(20.0)
            make.leading.equalTo(view.snp.leading).offset(40.0)
            make.trailing.equalTo(view.snp.trailing).offset(-40.0)
            make.height.greaterThanOrEqualTo(20.0)
        }
        
        form.snp.makeConstraints { (make) in
            make.topMargin.equalTo(alert.snp.bottom).offset(20.0)
            make.leading.equalTo(view.snp.leading).offset(40.0)
            make.trailing.equalTo(view.snp.trailing).offset(-40.0)
            make.height.equalTo(100.0)
        }
        
        link.snp.makeConstraints { (make) in
            make.topMargin.equalTo(form.snp.bottom).offset(40.0)
            make.leading.equalTo(view.snp.leading).offset(40.0)
            make.trailing.equalTo(view.snp.trailing).offset(-40.0)
            make.height.equalTo(20.0)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.topMargin.greaterThanOrEqualTo(link.snp.bottomMargin)
            make.leading.equalTo(view.snp.leading).offset(40.0)
            make.trailing.equalTo(view.snp.trailing).offset(-40.0)
            make.height.equalTo(40.0)
            make.bottomMargin.equalTo(-30.0)
        }
        
    }
    
    private func getLoginForm() -> UIView {
        loginField = TDField()
        loginField.placeholder = Text.userName.localized
        loginField.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        passwordField = TDField()
        passwordField.placeholder = Text.password.localized
        passwordField.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        let form = UIStackView(arrangedSubviews: [loginField, passwordField])
        form.translatesAutoresizingMaskIntoConstraints = false
        form.axis = .vertical
        form.distribution = .fillEqually
        form.alignment = .fill
        form.spacing = 20.0
        return form
    }
    
}

extension LoginViewController: LoginViewProtocol {
    
    func showAlert(with message: String) {
        hideLoader()
        alert.text = message
    }
    
    func invalidateUserField() {
        loginField.setToInvalid()
    }
    
    func invalidatePasswordField() {
        passwordField.setToInvalid()
    }
    
}
