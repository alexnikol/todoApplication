//
//  TodoListViewController.swift
//  TodoViperApp
//
//  Created by Alexander Nikolaychuk on 27.02.2020.
//  Copyright © 2020 AlexAlmostEngineer. All rights reserved.
//

import UIKit
import SnapKit

final class TodoListViewController: UITableViewController, Loaderable {
    
    private let contentView = UIView()
    var presenter: TodoListPresenterProtocol?
    
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
        presenter?.refreshList()
    }
    
    private func setupView() {}
    
}

extension TodoListViewController: TodoListViewProtocol {
    
    func showTodos(_ todos: [Todo]) {
        print("VIEW: \(todos)")
    }
    
    func showErrorMessage(_ message: String) {
        print("ERROR \(message)")
    }
    
}
