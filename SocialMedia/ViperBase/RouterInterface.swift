//
//  RouterInterface.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 27.12.2020.
//

import UIKit

protocol RouterInterface: AnyObject {
    func popFromNavigationController(animated: Bool)
    func dismiss(animated: Bool)

    func showErrorAlert(with message: String)
    func showAlert(with title: String, message: String)
}

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
}
