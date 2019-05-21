//
//  RepositoryViewModel.swift
//  CodingChallange
//
//  Created by Mounir Bittar on 5/20/19.
//  Copyright © 2019 Mounir Bittar. All rights reserved.
//

import UIKit

struct RepositoryViewModel {
    
    let name: String
    let description: String
    let stars_nb: String
    let ownerUsername: String
    let ownerAvatar: String

    init(repository: Repository) {
        self.name = repository.name ?? ""
        self.description = repository.description ?? ""
        self.stars_nb = "\(repository.stargazers_count)"
        self.ownerUsername = repository.owner.login ?? ""
        self.ownerAvatar = repository.owner.avatar_url ?? ""
    }    
}
