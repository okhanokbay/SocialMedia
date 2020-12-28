//
//  Comment.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//

import Foundation

struct CommentAPIResponse: Decodable {
    let postID: Int
    let commentID: Int
    let name: String
    let email: String
    let body: String

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case commentID = "id"
        case name
        case email
        case body
    }
}
