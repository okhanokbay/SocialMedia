//
//  PostsInteractorInputMock.swift
//  SocialMediaTests
//
//  Created by Okhan Okbay on 28.12.2020.
//

import Foundation
@testable import SocialMedia

final class PostsInteractorInputMock: PostsInteractorInputInterface {
    var getPostsCallCount = 0

    func getPosts() {
        getPostsCallCount += 1
    }

    var getDataProviderCallCount = 0

    func getDataProvider() -> PostDataProviderInterface {
        getDataProviderCallCount += 1
        return PostDataProviderMock()
    }

    var numberOfItemsCallCount = 0
    var numberOfItemsToReturn = 0

    func numberOfItems() -> Int {
        numberOfItemsCallCount += 1
        return numberOfItemsToReturn
    }

    var itemAtIndexCallCount = 0
    var itemAtIndexReceivedIndex: Int?
    var cellViewModelToReturn: PostViewModelProtocol!

    func item(at index: Int) -> PostViewModelProtocol {
        itemAtIndexCallCount += 1
        itemAtIndexReceivedIndex = index
        return cellViewModelToReturn
    }
}
