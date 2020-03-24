//
//  Resource.swift
//  NikeCodingTest
//
//  Created by Umair Ali on 22/03/2020.
//  Copyright © 2020 Umair Ali. All rights reserved.
//

import Foundation

struct Resource<T: Decodable> {
    let url: URL?
    let parameters: [String: CustomStringConvertible]
    var request: URLRequest? {
        guard
            let url = url,
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }
        components.queryItems = parameters.keys.map { key in
            URLQueryItem(name: key, value: parameters[key]?.description)
        }
        
        return URLRequest(url: url)
    }

    init(url: URL?, parameters: [String: CustomStringConvertible] = [:]) {
        self.url = url
        self.parameters = parameters
    }
}
