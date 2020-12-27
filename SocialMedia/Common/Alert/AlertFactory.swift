//
//  AlertFactory.swift
//  CleanSwiftSample
//
//  Created by Okhan Okbay on 24.10.2020.
//

import UIKit

extension AlertViewModel {
    var alertController: UIAlertController {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)

        let confirmAction = UIAlertAction(title: buttonText,
                                          style: .default,
                                          handler: nil)

        alertController.addAction(confirmAction)
        return alertController
    }
}
