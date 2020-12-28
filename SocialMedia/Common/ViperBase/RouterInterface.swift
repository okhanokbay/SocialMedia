//
//  RouterInterface.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 27.12.2020.
//

import UIKit

protocol RouterInterface: AnyObject {}

class BaseRouter: RouterInterface {
    private weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension BaseRouter {
    var navigationController: UINavigationController? {
        return viewController?.navigationController
    }
}

extension BaseRouter {
    func popFromNavigationController(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }

    func dismiss(animated: Bool) {
        (navigationController ?? viewController)?.dismiss(animated: animated)
    }
}
