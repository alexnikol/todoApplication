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
    
    var presenter: TodoListPresenterProtocol?
    var todosCount: Int {
        return presenter?.todos.count ?? 0
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        showLoader()
        setupView()
        presenter?.refreshList()
        let notificationName = Notification.Name(NotificationName.RefreshTodos.rawValue)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.refreshListMessage),
                                               name: notificationName,
                                               object: nil)
    }
    
    deinit {
        let notificationName = Notification.Name(NotificationName.RefreshTodos.rawValue)
        NotificationCenter.default.removeObserver(self, name: notificationName, object: nil)
    }
    
    private func setupView() {
        navigationItem.title = Text.todos.localized
        self.tableView.register(UINib(nibName: "TodoCell", bundle: nil),
                                forCellReuseIdentifier: CellName.TodoCell.rawValue)
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self,
                                  action: #selector(addTapped))
        let sort = UIBarButtonItem(title: Text.sort.localized, style: .plain, target: self,
                                   action: #selector(sortTapped))
        navigationItem.rightBarButtonItems = [add, sort]
        let refreshControll = UIRefreshControl()
        refreshControll.addTarget(self, action: #selector(runRefreashList), for: .valueChanged)
        refreshControll.tintColor = Colors.darkColor
        tableView.refreshControl = refreshControll
    }
    
    @objc
    func refreshListMessage(notification: NSNotification) {
        self.presenter?.refreshList()
    }
    
    @objc
    private func sortTapped() {
        
    }
    
    @objc
    private func addTapped() {
        presenter?.createTodo()
    }
    
    @objc
    private func runRefreashList() {
        presenter?.refreshList()
    }
    
    private func stopRefreshingVisits() {
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
}

extension TodoListViewController: TodoListViewProtocol {
    
    func refreshList() {
        tableView.reloadData()
        hideLoader()
        stopRefreshingVisits()
    }
        
    func showErrorMessage(_ message: String) {
        hideLoader()
        stopRefreshingVisits()
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
        
        cell.cellDidTap = { [weak self] in
            self?.presenter?.updateTodo(todo)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
        
    override func tableView(_ tableView: UITableView,
                            editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        guard let todo = presenter?.todos[indexPath.row] else {
            return nil
        }
        
        let delete = UITableViewRowAction(style: .destructive,
                                          title: Text.delete.localized) { [weak self] (_, _) in
            self?.presenter?.deleteTodo(byId: todo.id)
        }

        let edit = UITableViewRowAction(style: .normal,
                                        title: Text.edit.localized) { [weak self] (_, _) in
            self?.presenter?.updateTodo(todo)
        }

        edit.backgroundColor = Colors.darkColor

        return [delete, edit]
    }
    
}
