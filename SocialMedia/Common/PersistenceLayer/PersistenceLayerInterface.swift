//
//  PersistenceLayer.swift
//  ToDo
//
//  Created by Okhan Okbay on 8.11.2020.
//

import Foundation

typealias PersistenceLayerInterface = (PersistenceCreateLayerInterface &
                                       PersistenceReadLayerInterface &
                                       PersistenceUpdateLayerInterface)

// Persistence Layer segregated into CRUD protocols (no deletion in this project, so there is no D of the CRUD)

protocol PersistenceCreateLayerInterface: AnyObject {
    func save(posts: [PostViewModelProtocol],
              completion: ((_ isSuccess: Bool) -> Void)?)
}

protocol PersistenceReadLayerInterface: AnyObject {
    func fetchPosts(completion: @escaping ([PostViewModelProtocol]) -> Void)
    func fetchComments(for post: PostViewModelProtocol, completion: (([CommentViewModelProtocol]) -> Void)?)
}

protocol PersistenceUpdateLayerInterface: AnyObject {
    func update(post: PostViewModelProtocol,
                with comments: [CommentViewModelProtocol],
                completion: ((_ isSuccess: Bool) -> Void)?)
}
