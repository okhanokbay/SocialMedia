//
//  PostsInteractor.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation

final class PostsInteractor {
    private let dataProvider: PostDataProviderInterface
    weak var output: PostsInteractorOutputInterface!

    init(dataProvider: PostDataProviderInterface) {
        self.dataProvider = dataProvider
    }
}

// MARK: - InputInterface -

extension PostsInteractor: PostsInteractorInputInterface {
    func getPosts() {
        getPosts(on: DispatchQueue.global(qos: .userInitiated))
    }

    func getPosts(on queue: DispatchQueueType) {
        queue.async {
            self.dataProvider.fetchPosts(completion: { [weak self] posts in
                self?.output.postsReceived(posts)
            })
        }
    }

    func getDataProvider() -> PostDataProviderInterface {
        return dataProvider
    }

    func numberOfItems() -> Int {
        return dataProvider.currentPosts.count
    }

    func item(at index: Int) -> PostViewModelProtocol {
        return dataProvider.currentPosts[index]
    }
}
