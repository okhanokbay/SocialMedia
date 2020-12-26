//
//  MediationProtocol.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 27.12.2020.
//

import Foundation

protocol PostMediationProtocol {
    var postID: Int { get }
    var title: String { get }
    var body: String { get }
    var name: String { get }
    var username: String { get }
    var allComments: [CommentMediationProtocol] { get }
}
