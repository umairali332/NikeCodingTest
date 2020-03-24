//
//  AppDIContainer.swift
//  NikeCodingTest
//
//  Created by Umair Ali on 23/03/2020.
//  Copyright © 2020 Umair Ali. All rights reserved.
//

import UIKit

final class AppDIContainer {
    static let shared = AppDIContainer()
    lazy private(set) var imageLoader: ImageLoaderService = ImageLoaderService()
    lazy private(set) var network: NetworkServiceProtocol = NetworkService()
    lazy private(set) var albumUseCase: AlbumUseCaseProtocol = AlbumUseCase(networkService: network, imageLoaderService: imageLoader)
    lazy private(set) var albumControllerFactory: AlbumControllerFactory = AlbumControllerFactory(albumUseCase: albumUseCase)
    
    private init() {}
}
