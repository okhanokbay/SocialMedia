//
//  PostsInteractorOutputMock.swift
//  SocialMediaTests
//
//  Created by Okhan Okbay on 28.12.2020.
//

import Foundation
@testable import SocialMedia

final class PostsInteractorOutputMock: PostsInteractorOutputInterface {
    var postsReceivedCallCount = 0
    var postsReceivedViewModels: [PostViewModelProtocol] = []

    func postsReceived(_ posts: [PostViewModelProtocol]) {
        postsReceivedCallCount += 1
        postsReceivedViewModels = posts
    }
}
