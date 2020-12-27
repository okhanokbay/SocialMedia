//
//  PostDataProvider.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//

import Foundation

typealias PostDataProviderCompletion<T> = ([T]) -> Void

protocol PostDataProviderInterface: AnyObject {
    func fetchPosts(completion: @escaping PostDataProviderCompletion<PostViewModelProtocol>)
    func fetchComments(for postID: Int, completion: @escaping PostDataProviderCompletion<CommentViewModelProtocol>)
    
    var currentPosts: [PostViewModelProtocol] { get }
}

final class PostDataProvider {
    private let apiLayer: APILayerInterface
    private let apiResponseHandler: APIResponseHandlerInterface
    private let apiErrorHandler: APIErrorHandlerInterface
    
    private let persistenceLayerCreate: PersistenceLayerCreateInterface
    private let persistenceLayerRead: PersistenceLayerReadInterface
    private let persistenceLayerUpdate: PersistenceLayerUpdateInterface
    
    private let dataStore: PostDataStoreProtocol
    
    init(apiLayer: APILayerInterface,
         apiResponseHandler: APIResponseHandlerInterface,
         apiErrorHandler: APIErrorHandlerInterface,
         persistenceLayerCreate: PersistenceLayerCreateInterface,
         persistenceLayerRead: PersistenceLayerReadInterface,
         persistenceLayerUpdate: PersistenceLayerUpdateInterface,
         dataStore: PostDataStoreProtocol) {
        
        self.apiLayer = apiLayer
        self.apiResponseHandler = apiResponseHandler
        self.apiErrorHandler = apiErrorHandler
        
        self.persistenceLayerCreate = persistenceLayerCreate
        self.persistenceLayerRead = persistenceLayerRead
        self.persistenceLayerUpdate = persistenceLayerUpdate
        
        self.dataStore = dataStore
    }
}

// MARK: - Interface Methods -

extension PostDataProvider: PostDataProviderInterface {}

extension PostDataProvider {
    func fetchPosts(completion: @escaping PostDataProviderCompletion<PostViewModelProtocol>) {
        persistenceLayerRead.fetchPosts { [weak self] localPosts in
            guard let self = self else { return }
            
            if localPosts.count == 0 {
                self.fetchPostsFromAPI { remotePosts in
                    completion(remotePosts)
                }
            } else {
                completion(localPosts)
            }
        }
    }
    
    private func fetchPostsFromAPI(completion: @escaping PostDataProviderCompletion<PostViewModelProtocol>) {
        let taskGroup = DispatchGroup()
        
        taskGroup.enter()
        apiLayer.fetchUsers { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let users):
                self.dataStore.users = users
                
            case .failure(let error):
                self.apiErrorHandler.handleError(error)
            }
            
            taskGroup.leave()
        }
        
        taskGroup.enter()
        apiLayer.fetchPosts { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let posts):
                self.dataStore.posts = posts
                
            case .failure(let error):
                self.apiErrorHandler.handleError(error)
            }
            
            taskGroup.leave()
        }
        
        taskGroup.notify(queue: .main) { // No need to weakify the self here since the taskGroup is not owned by the self
            
            // Create a userDict to get related user object with postID in O(1) complexity
            let userDict: [Int: UserAPIResponse] = self.dataStore.users.reduce(into: [:]) { (result, response) in
                result[response.userID] = response
            }
            
            let postViewModels: [PostViewModelProtocol] = self.dataStore.posts.compactMap { post in
                guard let user = userDict[post.userID] else {
                    return nil
                }
                
                return PostViewModel(with: post, user: UserViewModel(with: user), comments: [])
            }
            
            self.dataStore.postViewModels = postViewModels
            completion(postViewModels)
        }
    }
    
    var currentPosts: [PostViewModelProtocol] {
        return dataStore.postViewModels
    }
}

extension PostDataProvider {
    func fetchComments(for postID: Int, completion: @escaping PostDataProviderCompletion<CommentViewModelProtocol>) {
        #warning("TODO")
    }
}