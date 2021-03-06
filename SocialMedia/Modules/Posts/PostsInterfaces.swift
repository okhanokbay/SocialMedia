//
//  PostsInterfaces.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

protocol PostsViewInterface: ViewInterface {
    func setTitle(_ title: String)
    func reloadInterface()
}

protocol PostsInteractorInputInterface: InteractorInterface {
    func getPosts()
    func getDataProvider() -> PostDataProviderInterface

    func numberOfItems() -> Int
    func item(at index: Int) -> PostViewModelProtocol
}

protocol PostsInteractorOutputInterface: InteractorInterface {
    func postsReceived(_ posts: [PostViewModelProtocol])
}

protocol PostsPresenterInterface: PresenterInterface {
    func numberOfItems() -> Int
    func item(at index: Int) -> MultiPurposeTableCellViewModelable

    func didSelectItem(at index: Int)
}

protocol PostsRouterInterface: RouterInterface {
    func navigateToPostDetail(with dataProvider: PostDataProviderInterface, post: PostViewModelProtocol)
}

protocol PostsWireframeInterface: WireframeInterface {
    static func assembleWireframe() -> PostsWireframe
}

protocol PostTableCellViewModelProtocol {
    var title: String { get }
}
