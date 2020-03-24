//
//  AlbumViewModel.swift
//  NikeCodingTest
//
//  Created by Umair Ali on 21/03/2020.
//  Copyright © 2020 Umair Ali. All rights reserved.
//

import Foundation
import Combine
import UIKit.UIImage

struct AlbumRowViewModel {
    var id: String { album.id }
    var name: String { album.name }
    var artist: String { album.artistName }
    let poster: AnyPublisher<UIImage?, Never>
    
    private let album: Album
    
    init(album: Album, poster: AnyPublisher<UIImage?, Never>) {
        self.album = album
        self.poster = poster
    }
}

extension AlbumRowViewModel: Hashable {
    static func == (lhs: AlbumRowViewModel, rhs: AlbumRowViewModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
