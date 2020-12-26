//
//  User.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//

import Foundation

struct User: Decodable {
    let userID: Int
    let name: String
    let surname: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "id"
        case name = "name"
        case surname = "surname"
    }
}
