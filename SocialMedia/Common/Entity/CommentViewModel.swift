//
//  CommentViewModel.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 27.12.2020.
//

import Foundation

struct CommentViewModel: CommentMediationProtocol, Hashable {
    let postID: Int
    let commentID: Int
    let name: String
    let email: String
    let body: String
    
    init(with commentAPIResponse: CommentAPIResponse) {
        postID = commentAPIResponse.postID
        commentID = commentAPIResponse.commentID
        name = commentAPIResponse.name
        email = commentAPIResponse.email
        body = commentAPIResponse.body
    }
}
