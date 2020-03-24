//
//  SceneDelegate.swift
//  NikeCodingTest
//
//  Created by Umair Ali on 21/03/2020.
//  Copyright © 2020 Umair Ali. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appNavigator: AppNavigator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let window = UIWindow(windowScene: windowScene)
        appNavigator = AppNavigator(window: window)
        appNavigator?.installAppRoot()
        self.window = window
        window.makeKeyAndVisible()
    }
}

