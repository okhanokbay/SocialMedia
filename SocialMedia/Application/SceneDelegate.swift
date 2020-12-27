//
//  SceneDelegate.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let postsNavigationController = PostsNavigationController()
        postsNavigationController.navigationBar.tintColor = .brown
        postsNavigationController.navigationBar.prefersLargeTitles = true

        let rootWireframe = PostsWireframe.assembleWireframe()
        postsNavigationController.setRootWireframe(rootWireframe)

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = postsNavigationController
        window?.makeKeyAndVisible()
    }
}
