//
//  ViewInterface.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//

import UIKit

protocol ViewInterface: AnyObject {
    func showProgressHUD()
    func hideProgressHUD()

    func showErrorAlert(with message: String, on viewController: UIViewController)
    func showAlert(with title: String, message: String, on viewController: UIViewController)
}

extension ViewInterface {
    func showProgressHUD(on view: UIView) {
        LoadingIndicator.shared.showLoading(on: view)
    }

    func hideProgressHUD() {
        LoadingIndicator.shared.hideLoading()
    }
}

extension ViewInterface {
    func showErrorAlert(with message: String, on viewController: UIViewController) {
        let alertViewModel = AlertViewModel(title: Strings.Alert.error.rawValue,
                                            message: message,
                                            buttonText: Strings.Alert.okay.rawValue)

        viewController.present(alertViewModel.alertController,
                               animated: true,
                               completion: nil)
    }

    func showAlert(with title: String, message: String, on viewController: UIViewController) {
        let alertViewModel = AlertViewModel(title: title,
                                            message: message,
                                            buttonText: Strings.Alert.okay.rawValue)

        viewController.present(alertViewModel.alertController,
                               animated: true,
                               completion: nil)
    }
}
