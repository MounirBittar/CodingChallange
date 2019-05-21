//
//  Service.swift
//  CodingChallange
//
//  Created by Mounir Bittar on 5/20/19.
//  Copyright © 2019 Mounir Bittar. All rights reserved.
//

import Foundation

let apiManager = Service.shared
class Service: NSObject {
    static let shared = Service()
    
    func fetchRepositories(date: String, page: Int, completion: @escaping (ApiResponse?, Error?) -> ()) {
        let urlString =  String(format:"%@%@?q=created:>%@&sort=stars&order=desc&page=%d", appConfig.apiUrl, ApiRoute.getRepositories, date ,page)
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                print("Failed to fetch repositories:", err)
                return
            }
            
            // check response
            
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(ApiResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response, nil)
                }
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
            }.resume()
    }
}
