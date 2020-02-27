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
    
    let contentView = UIView()
    var loginField: TDField!
    var passwordField: TDField!
    
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
    func toSignUpProcess() {}
    
    @objc
    func loginProccess() {}
    
    private func setupView() {
        loginField = TDField()
        loginField.placeholder = Text.userName.localized
        passwordField = TDField()
        passwordField.placeholder = Text.password.localized
        let link = UIButton(type: .system)
        link.setTitle(Text.toSignUpFlow.localized, for: .normal)
        let toSignUpProcess = UITapGestureRecognizer(target: self,
                                                     action: #selector(self.toSignUpProcess))
        link.addGestureRecognizer(toSignUpProcess)
        let form = UIStackView(arrangedSubviews: [loginField, passwordField])
        form.translatesAutoresizingMaskIntoConstraints = false
        form.axis = .vertical
        form.distribution = .fillEqually
        form.alignment = .fill
        form.spacing = 20.0
        let loginButton = TDButton(type: .system)
        loginButton.setTitle(Text.go.localized, for: .normal)
        let loginProcess = UITapGestureRecognizer(target: self,
                                                  action: #selector(self.toSignUpProcess))
        loginButton.addGestureRecognizer(loginProcess)
        self.view.addSubview(form)
        self.view.addSubview(link)
        self.view.addSubview(loginButton)
        
        form.snp.makeConstraints { (make) in
            make.topMargin.equalTo(view.snp.topMargin).offset(40.0)
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
    
}
