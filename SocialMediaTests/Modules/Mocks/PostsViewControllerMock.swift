//
//  PostsViewInterfaceMock.swift
//  SocialMediaTests
//
//  Created by Okhan Okbay on 28.12.2020.
//

import Foundation
@testable import SocialMedia

final class PostsViewControllerMock: PostsViewInterface {
    var setTitleCallCount = 0
    var setTitleReceivedString: String?

    func setTitle(_ title: String) {
        setTitleCallCount += 1
        setTitleReceivedString = title
    }

    var reloadInterfaceCallCount = 0

    func reloadInterface() {
        reloadInterfaceCallCount += 1
    }

    var showProgressHUDCallCount = 0

    func showProgressHUD() {
        showProgressHUDCallCount += 1
    }
}
