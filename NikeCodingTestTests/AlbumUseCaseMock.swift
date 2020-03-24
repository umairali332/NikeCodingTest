//
//  AlbumUseCaseMock.swift
//  NikeCodingTestTests
//
//  Created by Umair Ali on 23/03/2020.
//  Copyright © 2020 Umair Ali. All rights reserved.
//

@testable import NikeCodingTest
import Combine
import UIKit.UIImage

struct ErrorMock: Error {}

final class AlbumUseCaseMock: AlbumUseCaseProtocol {
    var albumsPublisher: AnyPublisher<Result<[Album], Error>, Never> = .just(.failure(ErrorMock()))
    var loadImagePublisher: AnyPublisher<UIImage?, Never> = .just(nil)
    
    func albums() -> AnyPublisher<Result<[Album], Error>, Never> {
        return albumsPublisher
    }
    
    func loadImage(for album: Album) -> AnyPublisher<UIImage?, Never> {
        return loadImagePublisher
    }
    

}
