//
//  PersistenceLayer.swift
//  ToDo
//
//  Created by Okhan Okbay on 8.11.2020.
//

import Foundation

protocol PersistenceLayerInterface: AnyObject {
    func fetchPosts(completion: @escaping ([PostViewModelProtocol]) -> Void)
    
    func save(posts: [PostViewModelProtocol],
              completion: ((_ isSuccess: Bool) -> Void)?)
    
    func update(post: PostViewModelProtocol,
                with comments: [CommentViewModelProtocol],
                completion: ((_ isSuccess: Bool) -> Void)?)
    
    func fetchComments(for postID: Int, completion: (([CommentViewModelProtocol]) -> Void)?)
}
