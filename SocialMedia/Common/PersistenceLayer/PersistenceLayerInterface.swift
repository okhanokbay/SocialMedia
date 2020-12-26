//
//  PersistenceLayer.swift
//  ToDo
//
//  Created by Okhan Okbay on 8.11.2020.
//

import Foundation

protocol PersistenceLayerInterface: AnyObject {
    func fetchPosts(completion: @escaping ([PostMediationProtocol]) -> Void)
    
    func save(posts: [PostMediationProtocol],
              completion: ((_ isSuccess: Bool) -> Void)?)
    
    func update(post: PostMediationProtocol,
                with comments: [CommentMediationProtocol],
                completion: ((_ isSuccess: Bool) -> Void)?)
    
    func fetchComments(for postID: Int, completion: (([CommentMediationProtocol]) -> Void)?)
}
