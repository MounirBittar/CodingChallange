//
//  RepositoryViewModel.swift
//  CodingChallange
//
//  Created by Mounir Bittar on 5/20/19.
//  Copyright © 2019 Mounir Bittar. All rights reserved.
//

import UIKit
import SwiftDate

class RepositoryViewModel {
    
    var name: String = ""
    var description: String = ""
    var stars_nb: String = ""
    var ownerUsername: String = ""
    var ownerAvatar: String = ""
    
    var repositoryViewModels: [RepositoryViewModel] = []
    /// isAllLoaed used to identify if all repositories are loaded
    var isAllLoaded = false
    /// current_page indicates last page loaded
    var current_page = 0
    
    init(repository: Repository? = nil) {
        if let repository = repository {
            self.name = repository.name ?? ""
            self.description = repository.description ?? ""
            self.stars_nb = "\(repository.stargazers_count)"
            self.ownerUsername = repository.owner.login ?? ""
            self.ownerAvatar = repository.owner.avatar_url ?? ""
        }
    }
    
    func fetchData(completion: @escaping (Error?) -> ()) {
        current_page += 1
        /// gets the date 30 days ago from today
        let thirtyDaysFromToday = (Date() - 30.days).toFormat("yyyy-MM-dd")
        apiManager.fetchRepositories(date: thirtyDaysFromToday, page: current_page, completion: { (response, error) in
            if let error = error {
                print("Failed to fetch Repositories:", error)
                completion(error)
                return
            }
            if self.current_page == 1 {
                self.repositoryViewModels = []
            }
            /// if the results are incomplete then there more data to load
            self.isAllLoaded = response!.incomplete_results
            self.repositoryViewModels.append(contentsOf: response?.items.map({return RepositoryViewModel(repository: $0)}) ?? [])
            completion(nil)
        })
    }
}
