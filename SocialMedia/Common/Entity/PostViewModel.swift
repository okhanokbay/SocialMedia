//
//  PostViewModel.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 27.12.2020.
//

import Foundation

struct PostViewModel {
    let userID: Int
    let postID: Int
    let title: String
    let body: String
    let name: String
    let username: String
    var comments: Set<CommentViewModel>
    
    init(with postAPIResponse: PostAPIResponse,
        userAPIResponse: UserAPIResponse,
        commentsAPIResponse: [CommentAPIResponse]) {
        
        userID = postAPIResponse.userID
        postID = postAPIResponse.postID
        title = postAPIResponse.title
        body = postAPIResponse.body
        
        name = userAPIResponse.name
        username = userAPIResponse.username
        
        comments = Set(commentsAPIResponse.map(CommentViewModel.init))
    }
}

extension PostViewModel: PostMediationProtocol {
    var allComments: [CommentMediationProtocol] {
        return Array(comments)
    }
}
