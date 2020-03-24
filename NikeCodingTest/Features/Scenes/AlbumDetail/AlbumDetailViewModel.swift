//
//  AlbumDetailViewModel.swift
//  NikeCodingTest
//
//  Created by Umair Ali on 23/03/2020.
//  Copyright © 2020 Umair Ali. All rights reserved.
//

import Foundation
import Combine
import UIKit.UIApplication

final class AlbumDetailViewModel {
    lazy private(set) var name = album.name
    lazy private(set) var artist = album.artistName
    lazy private(set) var releaseDate = album.releaseDate
    lazy private(set) var copyright = album.copyright
    lazy private(set) var genres = album.genres.map({ $0.name }).joined(separator: ", ")
    lazy private(set) var artURL = albumUseCase.loadImage(for: album).eraseToAnyPublisher()
    
    
    private let album: Album
    private let albumUseCase: AlbumUseCaseProtocol
    private unowned let navigator: AlbumDetailNavigating
    
    init(album: Album, navigator: AlbumDetailNavigating, albumUseCase: AlbumUseCaseProtocol) {
        self.album = album
        self.navigator = navigator
        self.albumUseCase = albumUseCase
    }
    
    @objc func openAlbumDidTap() {
        guard let albumURL = album.url else {
            return
        }
        
        navigator.openAlbum(forURL: albumURL)
    }
}
