//
//  AppNavigator.swift
//  MoviesListing
//
//  Created by Umair Ali on 30/04/2019.
//  Copyright © 2019 Umair Ali. All rights reserved.
//

import UIKit

final class AppNavigator {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func installAppRoot() {
        let navigationController = AppNavigationController()
        let albumNavigator = AlbumNavigator(rootController: navigationController,
                                            factory: AppDIContainer.shared.albumControllerFactory)
        albumNavigator.installAlbumRoot()
        window.rootViewController = navigationController
    }
}
