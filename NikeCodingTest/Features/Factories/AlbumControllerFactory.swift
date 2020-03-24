//
//  AlbumControllerFactory.swift
//  NikeCodingTest
//
//  Created by Umair Ali on 23/03/2020.
//  Copyright © 2020 Umair Ali. All rights reserved.
//

import UIKit

final class AlbumControllerFactory {
    private let albumUseCase: AlbumUseCaseProtocol
    
    init(albumUseCase: AlbumUseCaseProtocol) {
        self.albumUseCase = albumUseCase
    }
    
    func makeAlbumViewController(navigator: AlbumNavigating) -> UIViewController {
        let viewModel = AlbumViewModel(albumUseCase: albumUseCase, navigator: navigator)
        return AlbumViewController(viewModel: viewModel)
    }
    
    func makeAlbumDetailViewController(withAlbum album: Album, navigator: AlbumDetailNavigating) -> UIViewController {
        let viewModel = AlbumDetailViewModel(album: album,
                                             navigator: navigator,
                                             albumUseCase: albumUseCase)
        
        return AlbumDetailViewController(viewModel: viewModel)
    }
}
