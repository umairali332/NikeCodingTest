//
//  AlbumViewModel.swift
//  NikeCodingTest
//
//  Created by Umair Ali on 22/03/2020.
//  Copyright © 2020 Umair Ali. All rights reserved.
//

import Foundation
import Combine

enum AlbumViewModelState: Equatable {
    case loading
    case show([AlbumRowViewModel])
    case noResults
}

struct AlbumViewModelInput {
    /// called when a screen becomes visible
    let appear: AnyPublisher<Void, Never>
    /// called when the user selected an item from the list
    let selection: AnyPublisher<Int, Never>
}

typealias AlbumViewModelOuput = AnyPublisher<AlbumViewModelState, Never>

final class AlbumViewModel {
    private var cancellable: [AnyCancellable] = []
    private let albumUseCase: AlbumUseCaseProtocol
    private let navigator: AlbumNavigating
    private var albums: [Album] = []
    
    init(albumUseCase: AlbumUseCaseProtocol, navigator: AlbumNavigating) {
        self.albumUseCase = albumUseCase
        self.navigator = navigator
    }
    
    func transform(input: AlbumViewModelInput) -> AlbumViewModelOuput {
        cancellable.forEach { $0.cancel() }
        cancellable.removeAll()
        
        input.selection
            .map({ self.albums[$0] })
            .sink(receiveValue: navigator.showAlbumDetail)
            .store(in: &cancellable)
        
        let albums = input.appear
            .flatMap(albumUseCase.albums)
            .map(makeAlbumViewModelState)
            .eraseToAnyPublisher()
        
        let loading: AlbumViewModelOuput = input.appear
            .map({.loading})
            .eraseToAnyPublisher()
        
        return Publishers
            .Merge(loading, albums)
            .eraseToAnyPublisher()
        
    }
    
    func makeAlbumViewModelState(result: Result<[Album], Error>) -> AlbumViewModelState {
        switch result {
        case .failure(let error):
            navigator.showAlert(withError: error)
            return .noResults
        case .success(let albums):
            let albumRowViewModels = albums.map { album -> AlbumRowViewModel in
                AlbumRowViewModel(album: album, poster: self.albumUseCase.loadImage(for: album))
            }
            self.albums = albums
            return .show(albumRowViewModels)
        }
    }
}
