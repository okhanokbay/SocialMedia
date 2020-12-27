//
//  Post.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//

import Foundation

struct PostAPIResponse: Decodable {
    let userID: Int
    let postID: Int
    let title: String
    let body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case postID = "id"
        case title
        case body
    }
}
