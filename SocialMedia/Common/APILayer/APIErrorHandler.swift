//
//  APIErrorHandler.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//

import UIKit

protocol APIErrorHandlerInterface: AnyObject {
    func handleError(_ error: APIError)
}

final class APIErrorHandler: APIErrorHandlerInterface {
    func handleError(_ error: APIError) {
        let alertViewModel = AlertViewModel(title: Strings.Alert.error.rawValue,
                                            message: error.customDescription,
                                            buttonText: Strings.Alert.ok.rawValue)
        
        UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController?.show(alertViewModel.alertController, sender: nil)
    }
}
