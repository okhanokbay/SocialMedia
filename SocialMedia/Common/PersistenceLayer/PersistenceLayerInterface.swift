//
//  PersistenceLayer.swift
//  ToDo
//
//  Created by Okhan Okbay on 8.11.2020.
//

import Foundation

protocol PersistenceLayerInterface: AnyObject {
    func fetchPosts() -> [PostMediationProtocol]
    func save(posts: [PostMediationProtocol])
    func fetchComments(for postID: Int) -> [CommentMediationProtocol]
}
