//
//  Colors.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//

import UIKit

enum ImageFactory: String {
    case disclosureIndicator = "DisclosureIndicator"
    case rightArrow = "RightArrow"
    case profile = "Profile"
    case comment = "Comment"

    var image: UIImage {
        return UIImage(named: rawValue)!
    }
}
