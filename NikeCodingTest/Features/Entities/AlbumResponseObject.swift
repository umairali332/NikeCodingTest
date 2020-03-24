//
//  AlbumResponseObject.swift
//  NikeCodingTest
//
//  Created by Umair Ali on 22/03/2020.
//  Copyright © 2020 Umair Ali. All rights reserved.
//

import Foundation

struct AlbumResponseObject: Decodable {
    enum RootKeys: String, CodingKey {
        case feed
    }

    enum AlbumKeys: String, CodingKey {
        case albums = "results"
    }

    let albums: [Album]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        let feedContainer = try container.nestedContainer(keyedBy: AlbumKeys.self, forKey: .feed)
        albums = try feedContainer.decode([Album].self, forKey: .albums)
    }
}

