//
//  UIView+Extensions.swift
//  ToDo
//
//  Created by Okhan Okbay on 8.11.2020.
//

import UIKit

extension UIView {
  static var nib: UINib {
    return UINib(nibName: String(describing: self), bundle: Bundle(for: Self.self))
  }

  static func loadFromNib() -> Self {
    guard let view = Bundle(for: Self.self).loadNibNamed(String(describing: Self.self),
                                              owner: nil,
                                              options: nil)![0] as? Self else {
        fatalError("View could not be created from nib")
    }

    return view
  }
}
