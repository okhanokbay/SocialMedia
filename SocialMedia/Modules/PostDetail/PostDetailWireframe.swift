//
//  PostDetailWireframe.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class PostDetailWireframe: BaseWireframe {}

extension PostDetailWireframe: PostDetailWireframeInterface {
    // MARK: - Module setup -

    static func assembleWireframe(with dataProvider: PostDataProviderInterface,
                                  post: PostViewModelProtocol) -> PostDetailWireframe {

        let viewController = PostDetailViewController.loadFromNib()
        let wireframe = PostDetailWireframe(viewController: viewController)

        let router = PostDetailRouter(viewController: viewController)
        let interactor = PostDetailInteractor(dataProvider: dataProvider)
        let presenter = PostDetailPresenter(view: viewController,
                                            interactor: interactor,
                                            router: router,
                                            post: post)

        interactor.output = presenter
        viewController.presenter = presenter

        return wireframe
    }
}
