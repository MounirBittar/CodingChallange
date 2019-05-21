//
//  RepositoryController.swift
//  CodingChallange
//
//  Created by Mounir Bittar on 5/20/19.
//  Copyright © 2019 Mounir Bittar. All rights reserved.
//

import UIKit
import SwiftDate

class RepositoryController: UITableViewController, Stroyboarded {
    
    weak var coordinator: MainCoordinator?
    private var repositoryViewModels = [RepositoryViewModel]()
    private var isAllLoaded = false
    private var current_page = 0
    private let cellId = "RepositoryCell"
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchData()
    }
    
    // MARK: - private methods
    
    @objc fileprivate func fetchData() {
        current_page += 1
        apiManager.fetchRepositories(date: (Date() - 30.days).toFormat("yyyy-MM-dd"), page: current_page, completion: { (response, error) in
            self.tableView.refreshControl?.endRefreshing()
            if let error = error {
                print("Failed to fetch Repositories:", error)
                return
            }
            if self.current_page == 1 {
                self.repositoryViewModels = []
            }
            self.isAllLoaded = response!.incomplete_results
            self.repositoryViewModels.append(contentsOf: response?.items.map({return RepositoryViewModel(repository: $0)}) ?? [])
            self.tableView.reloadData()
        })
    }
    
    fileprivate func setupTableView() {
        let cell = UINib(nibName: cellId, bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: cellId)
        tableView.refreshControl = UIRefreshControl()
        tableView.tableFooterView = UIView()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
    }
    @objc fileprivate func refresh(sender:AnyObject) {
        current_page = 0
        fetchData()
    }
    
    // MARK: - UITableView delegate and dataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isAllLoaded ? repositoryViewModels.count : repositoryViewModels.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RepositoryCell
        cell.configure(with: isLoadingCell(for: indexPath) ? .none : repositoryViewModels[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < repositoryViewModels.count{
            let repository = repositoryViewModels[indexPath.row]
            coordinator?.openRepositoryDetails(repository)
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == repositoryViewModels.count - 1 && !isAllLoaded {
            self.fetchData()
        }
    }
}

private extension RepositoryController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= repositoryViewModels.count
    }
}
