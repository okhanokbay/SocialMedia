//
//  LoadingIndicator.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//

import UIKit
import NVActivityIndicatorView

final class LoadingIndicator {
    static let shared = LoadingIndicator()
    
    private let loadingWindow: UIWindow
    
    init(dimension: CGFloat = 44) {
        loadingWindow = UIWindow(frame: UIScreen.main.bounds)
        loadingWindow.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        var frame = loadingWindow.frame
        frame.size.height = dimension
        frame.size.width = dimension
        
        let indicator = NVActivityIndicatorView(frame: frame, type: .ballScaleMultiple, color: .blue, padding: nil)
        loadingWindow.addSubview(indicator)
        indicator.center = loadingWindow.center
        indicator.startAnimating()
    }
    
    func showLoading(on view: UIView) {
        DispatchQueue.main.async {
            self.loadingWindow.isHidden = false
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.loadingWindow.isHidden = false
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.loadingWindow.isHidden = true
        }
    }
}
