//
//  PostDetailRouter.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 27.12.2020.
//

import UIKit

final class PostDetailRouter: BaseRouter {}

extension PostDetailRouter: PostDetailRouterInterface {
    func navigateToBack() {
        popFromNavigationController(animated: true)
    }
}
