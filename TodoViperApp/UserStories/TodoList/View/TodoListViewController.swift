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
        presenter?.sortingButtonDidTap()
    }
    
    @objc
    private func addTapped() {
        presenter?.createTodo()
    }
    
    @objc
    private func runRefreashList() {
        presenter?.refreshList()
    }
    
    private func stopRefreshingTodos() {
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
        
}

extension TodoListViewController: TodoListViewProtocol {
    
    func updateNewItems(count: Int) {
        let lastElement = (presenter?.todos.count ?? 0) - 1 - count
        var indexPathsForInsert: [IndexPath] = []
        for item in (lastElement + 1 ... lastElement + count) {
            indexPathsForInsert.append(IndexPath(row: item, section: 0))
        }
        tableView.beginUpdates()
        tableView.insertRows(at: indexPathsForInsert, with: .automatic)
        tableView.endUpdates()
    }

    func refreshList() {
        tableView.reloadData()
        hideLoader()
        stopRefreshingTodos()
    }
        
    func showErrorMessage(_ message: String) {
        hideLoader()
        stopRefreshingTodos()
    }
    
}

extension TodoListViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        let isDataLoaded = presenter?.isAllDataLoaded ?? false
        if distanceFromBottom < height {
            if !isDataLoaded {
                presenter?.loadNextPage()
                let spinner = UIActivityIndicatorView(style: .gray)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                self.tableView.tableFooterView = spinner
                self.tableView.tableFooterView?.isHidden = false
            } else {
                self.tableView.tableFooterView = nil
            }
        }
    }

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
