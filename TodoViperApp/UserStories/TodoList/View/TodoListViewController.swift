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
    var todosCount: Int {
        return presenter?.todos.count ?? 0
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "TodoCell", bundle: nil),
                                forCellReuseIdentifier: CellName.TodoCell.rawValue)
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
    
    func refreshList() {
        tableView.reloadData()
    }
        
    func showErrorMessage(_ message: String) {
        print("ERROR \(message)")
    }
    
}

extension TodoListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todosCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let todos = presenter?.todos else {
            return UITableViewCell()
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellName.TodoCell.rawValue,
                                                       for: indexPath) as? TodoCell else {
            return UITableViewCell()
        }
        let todo = todos[indexPath.row]
        cell.update(message: todo.title,
                    priority: todo.priority,
                    dateLabel: Date.getTimeFromTS(timestamp: todo.dueBy))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
