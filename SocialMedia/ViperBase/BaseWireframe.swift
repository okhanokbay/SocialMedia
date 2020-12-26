//
//  BaseWireframe.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//

import UIKit

protocol WireframeInterface: AnyObject {
    func popFromNavigationController(animated: Bool)
    func dismiss(animated: Bool)

    func showErrorAlert(with message: String)
    func showAlert(with title: String, message: String)
    func showAlert(with title: String?, message: String?, actions: [UIAlertAction])
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

extension BaseWireframe: WireframeInterface {
    func popFromNavigationController(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }

    func dismiss(animated: Bool) {
        navigationController?.dismiss(animated: animated)
    }

    func showErrorAlert(with message: String) {
        let alertViewModel = AlertViewModel(title: Strings.Alert.error.rawValue, message: message, buttonText: Strings.Alert.ok.rawValue)
        navigationController?.present(alertViewModel.alertController, animated: true, completion: nil)
    }

    func showAlert(with title: String, message: String) {
        let alertViewModel = AlertViewModel(title: title, message: message, buttonText: Strings.Alert.ok.rawValue)
        navigationController?.present(alertViewModel.alertController, animated: true, completion: nil)
    }

    func showAlert(with title: String?, message: String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        navigationController?.present(alert, animated: true, completion: nil)
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

extension UIViewController {
    func presentWireframe(_ wireframe: BaseWireframe, animated: Bool = true, completion: (() -> Void)? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }
}

extension UINavigationController {
    func pushWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        pushViewController(wireframe.viewController, animated: animated)
    }

    func setRootWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        setViewControllers([wireframe.viewController], animated: animated)
    }
}

