//
//  PostDetailInteractor.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation

final class PostDetailInteractor {
    private let dataProvider: PostDataProviderInterface
    weak var output: PostDetailInteractorOutputInterface!

    init(dataProvider: PostDataProviderInterface) {
        self.dataProvider = dataProvider
    }
}

// MARK: - InputInterface -

extension PostDetailInteractor: PostDetailInteractorInputInterface {
    func getComments(for post: PostViewModelProtocol) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.dataProvider.fetchComments(for: post) { [weak self] comments in
                self?.output.commentsReceived(comments: comments)
            }
        }
    }
}
