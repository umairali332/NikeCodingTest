//
//  Album.swift
//  NikeCodingTest
//
//  Created by Umair Ali on 22/03/2020.
//  Copyright © 2020 Umair Ali. All rights reserved.
//

import Foundation

struct Album: Decodable {
    struct Genre: Decodable {
        let genreId: String
        let name: String
        let url: URL?
    }
    let artistName: String
    let id: String
    let releaseDate: String
    let name: String
    let artworkUrl100: URL?
    let copyright: String
    var genres: [Genre] = []
    let url: URL?
}
