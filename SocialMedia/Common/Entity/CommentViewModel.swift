//
//  CommentViewModel.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 27.12.2020.
//

import Foundation

protocol CommentViewModelProtocol {
    var postID: Int { get }
    var commentID: Int { get }
    var name: String { get }
    var email: String { get }
    var body: String { get }
}

struct CommentViewModel: CommentViewModelProtocol {
    let postID: Int
    let commentID: Int
    let name: String
    let email: String
    let body: String

    init(commentAPIResponse: CommentAPIResponse) {
        self.init(postID: commentAPIResponse.postID,
                  commentID: commentAPIResponse.commentID,
                  name: commentAPIResponse.name,
                  email: commentAPIResponse.email,
                  body: commentAPIResponse.body)
    }

    init(postID: Int, commentID: Int, name: String, email: String, body: String) {
        self.postID = postID
        self.commentID = commentID
        self.name = name
        self.email = email
        self.body = body
    }
}
