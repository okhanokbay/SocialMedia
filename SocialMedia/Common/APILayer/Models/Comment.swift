//
//  Comment.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//

import Foundation

struct Comment: Decodable {
    let postID: Int
    let commentID: Int
    let name: String
    let body: String
    
    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case commentID = "id"
        case name = "name"
        case body = "body"
    }
}

struct CommentRequest: Encodable {
    let postID: Int
    
    enum CodingKeys: String, CodingKey {
        case postID = "postId"
    }
}
