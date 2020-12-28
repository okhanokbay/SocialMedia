//
//  PostsPresenterTests.swift
//  SocialMediaTests
//
//  Created by Okhan Okbay on 28.12.2020.
//

import XCTest
@testable import SocialMedia

final class PostsPresenterTests: XCTestCase {

    private var sut: PostsPresenter!

    private var viewMock: PostsViewControllerMock!
    private var interactorMock: PostsInteractorInputMock!
    private var routerMock: PostsRouterMock!

    override func setUpWithError() throws {
        viewMock = PostsViewControllerMock()
        interactorMock = PostsInteractorInputMock()
        routerMock = PostsRouterMock()

        sut = PostsPresenter(view: viewMock, interactor: interactorMock, router: routerMock)
    }
}

// MARK: - View Did Load Tests -

extension PostsPresenterTests {
    func test_WhenViewDidLoadCalled_ThenCorrectMethodCallsAreMade() {
        // Given
        let mockQueue = DispatchQueueMock()

        // When
        sut.viewDidLoad(on: mockQueue)

        // Then
        XCTAssertEqual(viewMock.setTitleCallCount, 1, "setTitle(_:) is not called 1 time")
    }
}

// MARK: - Posts Received Tests -

extension PostsPresenterTests {
    func test_WhenPostsReceivedCalled_ThenCellViewModelsArePopulated() {
        // Given
        let posts = DataHelper.makePosts()

        // When
        sut.postsReceived(posts)

        // Then
        XCTAssertEqual(sut.cellViewModels.count, posts.count, "Cell view models are not set as expected")
    }
}
