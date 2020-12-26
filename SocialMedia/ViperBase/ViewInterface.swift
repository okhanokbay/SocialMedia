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
    func showProgressHUD() {
        LoadingIndicator.shared.showLoading()
    }

    func hideProgressHUD() {
        LoadingIndicator.shared.hideLoading()
    }
}
