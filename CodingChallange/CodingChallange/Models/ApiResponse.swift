//
//  ApiResponse.swift
//  CodingChallange
//
//  Created by Mounir Bittar on 5/20/19.
//  Copyright © 2019 Mounir Bittar. All rights reserved.
//

import Foundation

struct ApiResponse: Decodable {
    let total_count: Int
    let incomplete_results: Bool
    let items: [Repository]
}
