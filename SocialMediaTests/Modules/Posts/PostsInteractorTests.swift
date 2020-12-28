//
//  PostsInteractorTests.swift
//  SocialMediaTests
//
//  Created by Okhan Okbay on 28.12.2020.
//

import XCTest
@testable import SocialMedia

final class PostsInteractorTests: XCTestCase {

    private var sut: PostsInteractor!
    private var dataProviderMock: PostDataProviderMock!
    private var postsInteractorOutputMock: PostsInteractorOutputMock!

    override func setUpWithError() throws {
        dataProviderMock = PostDataProviderMock()
        sut = PostsInteractor(dataProvider: dataProviderMock)

        postsInteractorOutputMock = PostsInteractorOutputMock()
        sut.output = postsInteractorOutputMock
    }
}

// MARK: - Get Posts Tests -

extension PostsInteractorTests {
    func test_WhenGetPostsCalled_ThenDataProviderFetchPostsCallede() {
        makeTestCallToGetPosts()

        // Then
        XCTAssertEqual(dataProviderMock.fetchPostsCallCount,
                       1,
                       "fetchPosts(completion:) is not called 1 time")
    }

    func test_WhenGetPostsCalled_ThenOutputPostsReceivedCalled() {
        makeTestCallToGetPosts()

        // Then
        XCTAssertEqual(postsInteractorOutputMock.postsReceivedCallCount,
                       1,
                       "postsReceived(_:) is not called 1 time")

        XCTAssertEqual(postsInteractorOutputMock.postsReceivedViewModels.first?.title,
                       "TestTitle",
                       "Received view models are not as expected")
    }

    func makeTestCallToGetPosts() {
        // Given
        let mockQueue = DispatchQueueMock()

        // When
        sut.getPosts(on: mockQueue)
    }
}
