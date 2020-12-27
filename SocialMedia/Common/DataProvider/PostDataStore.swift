//
//  PostDataStore.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 27.12.2020.
//

import Foundation

protocol PostDataStoreProtocol: AnyObject {
    var posts: [PostAPIResponse] { get set }
    var comments: [CommentAPIResponse] { get set }
    var users: [UserAPIResponse] { get set }
    
    var postViewModels: [PostViewModelProtocol] { get set }
}

final class PostDataStore: PostDataStoreProtocol {
    var posts: [PostAPIResponse] = []
    var comments: [CommentAPIResponse] = []
    var users: [UserAPIResponse] = []
    
    var postViewModels: [PostViewModelProtocol] = []
}
