//
//  PostDataProviderMock.swift
//  SocialMediaTests
//
//  Created by Okhan Okbay on 28.12.2020.
//

import Foundation
@testable import SocialMedia

final class PostDataProviderMock: PostDataProviderInterface {

    var fetchPostsCallCount = 0

    func fetchPosts(completion: @escaping PostDataProviderCompletion<PostViewModelProtocol>) {
        fetchPostsCallCount += 1
        completion(DataHelper.makePosts())
    }

    var fetchCommentsCallCount = 0
    var fetchCommentsReceivedPost: PostViewModelProtocol?

    func fetchComments(for post: PostViewModelProtocol,
                       completion: @escaping PostDataProviderCompletion<CommentViewModelProtocol>) {

        fetchCommentsCallCount += 1
        fetchCommentsReceivedPost = post
        completion(DataHelper.makeComments())
    }

    var currentPosts: [PostViewModelProtocol] {
        return DataHelper.makePosts()
    }
}
