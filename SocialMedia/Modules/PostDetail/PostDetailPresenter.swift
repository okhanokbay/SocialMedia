//
//  PostDetailPresenter.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation

final class PostDetailPresenter {
    
    // MARK: - Private properties -
    
    private unowned let view: PostDetailViewInterface
    private let interactor: PostDetailInteractorInputInterface
    private let router: PostDetailRouterInterface
    private let postID: Int
    
    // MARK: - Lifecycle -
    
    init(view: PostDetailViewInterface,
         interactor: PostDetailInteractorInputInterface,
         router: PostDetailRouterInterface,
         postID: Int) {
        
        self.view = view
        self.interactor = interactor
        self.router = router
        self.postID = postID
    }
}

// MARK: - Extensions -

extension PostDetailPresenter: PostDetailPresenterInterface {
    func viewDidLoad() {
        view.showProgressHUD()
        interactor.getComments(for: postID)
    }
}

extension PostDetailPresenter: PostDetailInteractorOutputInterface {
    func commentsReceived(comments: [CommentViewModelProtocol]) {
        // Generate stack view model here
        
        view.hideProgressHUD()
        view.reloadInterface()
    }
}
