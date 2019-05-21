//
//  Repository.swift
//  CodingChallange
//
//  Created by Mounir Bittar on 5/20/19.
//  Copyright © 2019 Mounir Bittar. All rights reserved.
//

import Foundation

struct Repository: Decodable {
    let id: Int
    let name: String?
    let stargazers_count: Int
    let description: String?
    let owner: Owner
}
