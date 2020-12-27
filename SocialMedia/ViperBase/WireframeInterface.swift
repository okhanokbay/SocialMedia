//
//  BaseWireframe.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 27.12.2020.
//

import UIKit

protocol WireframeInterface: AnyObject {
    var viewController: UIViewController { get }
    var navigationController: UINavigationController? { get }
}

class BaseWireframe {
    private unowned var innerViewController: UIViewController

    //to retain view controller reference upon first access
    private var temporaryStoredViewController: UIViewController?

    init(viewController: UIViewController) {
        temporaryStoredViewController = viewController
        innerViewController = viewController
    }
}

extension BaseWireframe {
    var viewController: UIViewController {
        defer { temporaryStoredViewController = nil }
        return innerViewController
    }

    var navigationController: UINavigationController? {
        return viewController.navigationController
    }
}
