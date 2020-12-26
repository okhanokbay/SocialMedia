//
//  UITableViewCell+Extensions.swift
//  ToDo
//
//  Created by Okhan Okbay on 8.11.2020.
//

import UIKit

extension UITableViewCell {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}
