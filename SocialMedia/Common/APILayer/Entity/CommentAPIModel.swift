//
//  Comment.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//

import Foundation

struct CommentAPIRequest: Encodable {
    let postID: Int
    
    enum CodingKeys: String, CodingKey {
        case postID = "postId"
    }
}

struct CommentAPIResponse: Decodable, Hashable {
    let postID: Int
    let commentID: Int
    let name: String
    let email: String
    let body: String
    
    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case commentID = "id"
        case name = "name"
        case email = "email"
        case body = "body"
    }
}
