//
//  PostsRouterMock.swift
//  SocialMediaTests
//
//  Created by Okhan Okbay on 28.12.2020.
//

import Foundation
@testable import SocialMedia

final class PostsRouterMock: PostsRouterInterface {
    var navigateToPostDetailCallCount = 0
    var navigateToPostDetailReceivedPost: PostViewModelProtocol?

    func navigateToPostDetail(with dataProvider: PostDataProviderInterface, post: PostViewModelProtocol) {
        navigateToPostDetailCallCount += 1
        navigateToPostDetailReceivedPost = post
    }
}
