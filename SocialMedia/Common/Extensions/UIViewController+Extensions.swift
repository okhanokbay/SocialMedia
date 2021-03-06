//
//  UIViewController+Extensions.swift
//  todo
//
//  Created by Okhan Okbay on 7.11.2020.
//

import UIKit

extension UIViewController {
  static func loadFromNib() -> Self {
    func instantiateFromNib<T: UIViewController>() -> T {
      return T.init(nibName: String(describing: T.self), bundle: nil)
    }

    return instantiateFromNib()
  }
}

extension UIViewController {
    func presentWireframe(_ wireframe: WireframeInterface, animated: Bool = true, completion: (() -> Void)? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }
}
