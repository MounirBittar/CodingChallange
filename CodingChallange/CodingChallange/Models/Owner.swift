//
//  Owner.swift
//  CodingChallange
//
//  Created by Mounir Bittar on 5/20/19.
//  Copyright © 2019 Mounir Bittar. All rights reserved.
//

import Foundation

struct Owner: Decodable {
    let id: Int
    let login: String?
    let avatar_url: String?
}
