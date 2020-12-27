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
}

extension ViewInterface {
    func showProgressHUD(on view: UIView) {
        LoadingIndicator.shared.showLoading(on: view)
    }

    func hideProgressHUD() {
        LoadingIndicator.shared.hideLoading()
    }
}
