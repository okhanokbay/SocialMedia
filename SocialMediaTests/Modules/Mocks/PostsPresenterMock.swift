//
//  PostsPresenterMock.swift
//  SocialMediaTests
//
//  Created by Okhan Okbay on 28.12.2020.
//

import Foundation
@testable import SocialMedia

final class PostsPresenterMock: PostsPresenterInterface {

    var numberOfItemsCallCount = 0
    var numberOfItemsToReturn = 0

    func numberOfItems() -> Int {
        numberOfItemsCallCount += 1
        return numberOfItemsToReturn
    }

    var itemAtIndexCallCount = 0
    var itemAtIndexReceivedIndex: Int?
    var cellViewModelToReturn: MultiPurposeTableCellViewModelable?

    func item(at index: Int) -> MultiPurposeTableCellViewModelable {
        itemAtIndexCallCount += 1
        itemAtIndexReceivedIndex = index
        return cellViewModelToReturn ?? MultiPurposeTableCellViewModel(firstText: "Test")
    }

    var didSelectItemCallCount =  0
    var didSelectedItemReceivedIndex: Int?

    func didSelectItem(at index: Int) {
        didSelectItemCallCount += 1
        didSelectedItemReceivedIndex = index
    }
}
