//
//  AppConfig.swift
//  CodingChallange
//
//  Created by Mounir Bittar on 5/20/19.
//  Copyright © 2019 Mounir Bittar. All rights reserved.
//

import Foundation

let appConfig = AppConfig.shared

class AppConfig: NSObject {
    static var shared = AppConfig()
    var apiUrl: String { return "https://api.github.com/" }
}
