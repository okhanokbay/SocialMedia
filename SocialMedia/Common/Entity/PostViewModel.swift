//
//  PostViewModel.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 27.12.2020.
//

import Foundation

protocol PostViewModelProtocol {
    var userID: Int { get }
    var postID: Int { get }
    var title: String { get }
    var body: String { get }
    var name: String { get }
    var username: String { get }
    var comments: [CommentViewModelProtocol] { get }
}

struct PostViewModel: PostViewModelProtocol {
    let userID: Int
    let postID: Int
    let title: String
    let body: String
    let name: String
    let username: String
    let comments: [CommentViewModelProtocol]

    init(with postAPIResponse: PostAPIResponse,
         user: UserViewModelProtocol,
         comments: [CommentViewModelProtocol]) {

        userID = postAPIResponse.userID
        postID = postAPIResponse.postID
        title = postAPIResponse.title
        body = postAPIResponse.body

        name = user.name
        username = user.username

        self.comments = comments
    }
}
