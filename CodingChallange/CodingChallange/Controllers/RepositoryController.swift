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
    private let cellId = "RepositoryCell"
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchData()
    }
    
    // MARK: - private methods
    
    @objc fileprivate func fetchData() {
        apiManager.fetchRepositories(date: (Date() - 30.days).toFormat("yyyy-MM-dd"), page: 0, completion: { (response, error) in
            self.tableView.refreshControl?.endRefreshing()
            if let error = error {
                print("Failed to fetch Repositories:", error)
                return
            }
          
            self.repositoryViewModels.append(contentsOf: response?.items.map({return RepositoryViewModel(repository: $0)}) ?? [])
            self.tableView.reloadData()
        })
    }
    
    fileprivate func setupTableView() {
        let cell = UINib(nibName: cellId, bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: cellId)
    }

    
    // MARK: - UITableView delegate and dataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoryViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RepositoryCell
        cell.configure(with: isLoadingCell(for: indexPath) ? .none : repositoryViewModels[indexPath.row])
        return cell
    }

}

private extension RepositoryController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= repositoryViewModels.count
    }
}
