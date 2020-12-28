//
//  DataHelper.swift
//  SocialMediaTests
//
//  Created by Okhan Okbay on 28.12.2020.
//

import Foundation
@testable import SocialMedia

final class DataHelper {
    static func makePosts() -> [PostViewModelProtocol] {
        let posts: [PostAPIResponse] = TestHelper.loadJSONFromFile(name: StubFilename.posts.rawValue)
        let commentViewModels = makeComments()

        let postViewModels: [PostViewModel] = posts.map { post in
            let userID = post.userID
            let mockUser = UserViewModel(userID: userID, name: "MockName\(userID)", username: "MockUsername\(userID)")

            return .init(with: post, user: mockUser, comments: commentViewModels)
        }

        return postViewModels
    }

    static func makeComments() -> [CommentViewModelProtocol] {
        let comments: [CommentAPIResponse] = TestHelper.loadJSONFromFile(name: StubFilename.comments.rawValue)
        return comments.map(CommentViewModel.init)
    }
}
