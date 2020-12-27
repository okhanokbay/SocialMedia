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
    
    private let progressHUD: UIView
    private let indicator: NVActivityIndicatorView
    
    init(dimension: CGFloat = 44 ) {
        let frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)
        indicator = NVActivityIndicatorView(frame: frame, type: .ballScaleMultiple, color: .brown, padding: nil)
        
        progressHUD = UIView(frame: .zero)
        progressHUD.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        progressHUD.addSubview(indicator)
    }
    
    func showLoading(on view: UIView) {
        progressHUD.frame = view.frame
        indicator.center = progressHUD.center
        
        view.addSubview(progressHUD)
        view.bringSubviewToFront(progressHUD)
        
        indicator.startAnimating()
    }
    
    func hideLoading() {
        progressHUD.removeFromSuperview()
        indicator.stopAnimating()
    }
}
