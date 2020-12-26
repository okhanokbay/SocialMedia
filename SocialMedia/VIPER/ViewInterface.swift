import UIKit

protocol ViewInterface: class {
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
