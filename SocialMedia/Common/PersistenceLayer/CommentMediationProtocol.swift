//
//  CommentMediationProtocol.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 27.12.2020.
//

import Foundation

protocol CommentMediationProtocol {
    var postID: Int { get }
    var commentID: Int { get }
    var name: String { get }
    var email: String { get }
    var body: String { get }
}
