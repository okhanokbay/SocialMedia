//
//  PostsRouter.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 27.12.2020.
//

import UIKit

final class PostsRouter: BaseRouter {}

extension PostsRouter: PostsRouterInterface {
    func navigateToPostDetail(with dataProvider: PostDataProviderInterface, postID: Int) {
        let postDetailWireframe = PostDetailWireframe.assembleWireframe(with: dataProvider, postID: postID)
        navigationController?.pushWireframe(postDetailWireframe, animated: true)
    }
}
