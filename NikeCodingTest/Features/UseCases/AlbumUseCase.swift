//
//  AlbumUseCase.swift
//  NikeCodingTest
//
//  Created by Umair Ali on 22/03/2020.
//  Copyright © 2020 Umair Ali. All rights reserved.
//

import Foundation
import Combine
import UIKit.UIImage

protocol AlbumUseCaseProtocol {
    func albums() -> AnyPublisher<Result<[Album], Error>, Never>
    // Loads image for the given movie
    func loadImage(for album: Album) -> AnyPublisher<UIImage?, Never>
}

struct AlbumUseCase {
    private let networkService: NetworkServiceProtocol
    private let imageLoaderService: ImageLoaderServiceProtocol
    
    init(networkService: NetworkServiceProtocol, imageLoaderService: ImageLoaderServiceProtocol) {
        self.networkService = networkService
        self.imageLoaderService = imageLoaderService
    }
}

extension AlbumUseCase: AlbumUseCaseProtocol {
    func albums() -> AnyPublisher<Result<[Album], Error>, Never> {
        let resource = Resource<AlbumResponseObject>(url: URL(string: Constants.API.albums))
        
        return networkService.execute(resource)
            .map({ (result: Result<AlbumResponseObject, NetworkError>) -> Result<[Album], Error> in
                switch result {
                case .success(let albumResponse): return .success(albumResponse.albums)
                case .failure(let error): return .failure(error)
                }
            })
            .subscribe(on: backgroundWorkScheduler)
            .receive(on: mainScheduler)
            .eraseToAnyPublisher()
    }
    
    func loadImage(for album: Album) -> AnyPublisher<UIImage?, Never> {
        return Deferred { return Just(album.artworkUrl100) }
        .flatMap(imageLoaderService.loadImage)
        .subscribe(on: backgroundWorkScheduler)
        .receive(on: mainScheduler)
        .share()
        .eraseToAnyPublisher()
    }
}
