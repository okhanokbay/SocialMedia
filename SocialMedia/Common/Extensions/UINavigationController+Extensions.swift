//
//  UINavigationController+Extensions.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 27.12.2020.
//

import UIKit

extension UINavigationController {
    func pushWireframe(_ wireframe: WireframeInterface, animated: Bool = true) {
        pushViewController(wireframe.viewController, animated: animated)
    }

    func setRootWireframe(_ wireframe: WireframeInterface, animated: Bool = true) {
        setViewControllers([wireframe.viewController], animated: animated)
    }
}
