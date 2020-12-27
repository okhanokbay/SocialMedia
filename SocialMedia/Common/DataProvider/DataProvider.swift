//
//  DataProvider.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//

import Foundation

typealias DataProviderCompletion<T> = ([T]) -> Void

protocol DataProviderInterface: AnyObject {
    func getPosts(completion: @escaping DataProviderCompletion<PostViewModelProtocol>)
    func getComments(for postID: Int, completion: @escaping DataProviderCompletion<CommentViewModelProtocol>)
}

final class DataProvider {
    private let apiLayer: APILayerInterface
    private let apiResponseHandler: APIResponseHandlerInterface
    private let apiErrorHandler: APIErrorHandlerInterface
    
    private let persistenceLayer: PersistenceLayerInterface
    private let dataStore: DataStoreProtocol
    
    init(apiLayer: APILayerInterface,
         apiResponseHandler: APIResponseHandlerInterface,
         apiErrorHandler: APIErrorHandlerInterface,
         persistenceLayer: PersistenceLayerInterface,
         dataStore: DataStoreProtocol) {
        
        self.apiLayer = apiLayer
        self.apiResponseHandler = apiResponseHandler
        self.apiErrorHandler = apiErrorHandler
        
        self.persistenceLayer = persistenceLayer
        self.dataStore = dataStore
    }
}

// MARK: - Interface Methods -

extension DataProvider: DataProviderInterface {}

extension DataProvider {
    func getPosts(completion: @escaping DataProviderCompletion<PostViewModelProtocol>) {
        persistenceLayer.fetchPosts { [weak self] localPosts in
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
    
    private func fetchPostsFromAPI(completion: @escaping DataProviderCompletion<PostViewModelProtocol>) {
        let taskGroup = DispatchGroup()
        
        taskGroup.enter()
        apiLayer.getUsers { [weak self] result in
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
        apiLayer.getPosts { [weak self] result in
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
            
            let posts: [PostViewModelProtocol] = self.dataStore.posts.compactMap { post in
                guard let user = userDict[post.userID] else {
                    return nil
                }
                
                return PostViewModel(with: post, user: UserViewModel(with: user), comments: [])
            }
            completion(posts)
        }
    }
}

extension DataProvider {
    func getComments(for postID: Int, completion: @escaping DataProviderCompletion<CommentViewModelProtocol>) {
        #warning("TODO")
    }
}
