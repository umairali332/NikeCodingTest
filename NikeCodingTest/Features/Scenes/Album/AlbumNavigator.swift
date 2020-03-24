//
//  AlbumNavigator.swift
//  NikeCodingTest
//
//  Created by Umair Ali on 22/03/2020.
//  Copyright © 2020 Umair Ali. All rights reserved.
//

import UIKit

protocol AlbumNavigating {
    func showAlbumDetail(forAlbum album: Album)
    func showAlert(withError error: Error)
}

protocol AlbumDetailNavigating: class {
    func openAlbum(forURL url: URL)
}

final class AlbumNavigator {
    private let rootController: UINavigationController
    private let factory: AlbumControllerFactory
    
    init(rootController: UINavigationController, factory: AlbumControllerFactory) {
        self.rootController = rootController
        self.factory = factory
    }
    
    func installAlbumRoot() {
        let viewController = factory.makeAlbumViewController(navigator: self)
        rootController.setViewControllers([viewController], animated: true)
    }
}

extension AlbumNavigator: AlbumNavigating {
    func showAlbumDetail(forAlbum album: Album) {
        let viewController = factory.makeAlbumDetailViewController(withAlbum: album, navigator: self)
        rootController.pushViewController(viewController, animated: true)
    }
    
    func showAlert(withError error: Error) {
        rootController.showAlert(with: error)
    }
}

extension AlbumNavigator: AlbumDetailNavigating {
    func openAlbum(forURL url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
