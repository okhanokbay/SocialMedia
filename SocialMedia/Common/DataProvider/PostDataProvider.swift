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
    func fetchComments(for post: PostViewModelProtocol, completion: @escaping PostDataProviderCompletion<CommentViewModelProtocol>)
    
    var currentPosts: [PostViewModelProtocol] { get }
}

final class PostDataProvider {
    private let apiLayer: APILayerInterface
    private let apiErrorHandler: APIErrorHandlerInterface
    
    private let persistenceLayer: PersistenceLayerInterface
    private let dataStore: PostDataStoreProtocol
    
    init(apiLayer: APILayerInterface,
         apiErrorHandler: APIErrorHandlerInterface,
         persistenceLayer: PersistenceLayerInterface,
         dataStore: PostDataStoreProtocol) {
        
        self.apiLayer = apiLayer
        self.apiErrorHandler = apiErrorHandler
        
        self.persistenceLayer = persistenceLayer
        self.dataStore = dataStore
    }
    
    var currentPosts: [PostViewModelProtocol] {
        return dataStore.postViewModels
    }
}

// MARK: - Interface Methods -

extension PostDataProvider: PostDataProviderInterface {}

extension PostDataProvider {
    func fetchPosts(completion: @escaping PostDataProviderCompletion<PostViewModelProtocol>) {
        persistenceLayer.fetchPosts { [weak self] localPosts in
            guard let self = self else { return }
            
            guard localPosts.count == 0 else {
                self.dataStore.postViewModels = localPosts
                completion(localPosts)
                print("Using posts from local warehouse")
                return
            }
            
            self.fetchPostsFromAPI { remotePosts in
                self.dataStore.postViewModels = remotePosts
                completion(remotePosts)
                print("Using posts from remote server")
                
                self.persistenceLayer.save(posts: remotePosts) { isSuccess in
                    print("Remote posts \(isSuccess ? "successfully" : "could not be") saved into local warehouse")
                }
            }
        }
    }
    
    private func fetchPostsFromAPI(completion: @escaping PostDataProviderCompletion<PostViewModelProtocol>) {
        let taskGroup = DispatchGroup()
        
        taskGroup.enter()
        apiLayer.fetchUsers(completion: fetchUsersCompletionHandler(taskGroup: taskGroup))
        
        taskGroup.enter()
        apiLayer.fetchPosts(completion: fetchPostsCompletionHandler(taskGroup: taskGroup))
        
        taskGroup.notify(queue: .main, execute: taskGroupCompletionHandler(completion: completion))
    }
    
    private func fetchUsersCompletionHandler(taskGroup: DispatchGroup) -> (ResponseHandler<[UserAPIResponse]>) {
        return { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let users):
                self.dataStore.users = users
                
            case .failure(let error):
                self.apiErrorHandler.handleError(error)
            }
            
            taskGroup.leave()
        }
    }
    
    private func fetchPostsCompletionHandler(taskGroup: DispatchGroup) -> (ResponseHandler<[PostAPIResponse]>) {
        return { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let posts):
                self.dataStore.posts = posts
                
            case .failure(let error):
                self.apiErrorHandler.handleError(error)
            }
            
            taskGroup.leave()
        }
    }
    
    private func taskGroupCompletionHandler(completion: @escaping PostDataProviderCompletion<PostViewModelProtocol>) -> () -> Void {
        return { [weak self] in
            guard let self = self else { return }
            
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
            
            completion(postViewModels)
        }
    }
}

extension PostDataProvider {
    func fetchComments(for post: PostViewModelProtocol,
                       completion: @escaping PostDataProviderCompletion<CommentViewModelProtocol>) {
        
        persistenceLayer.fetchComments(for: post) { [weak self] localComments in
            guard let self = self else { return }
            
            guard localComments.count == 0 else {
                self.dataStore.commentViewModels = localComments
                completion(localComments)
                print("Using comments from local warehouse")
                return
            }
            
            self.fetchCommentsFromAPI(for: post) { remoteComments in
                self.dataStore.commentViewModels = remoteComments
                completion(remoteComments)
                print("Using comments from remote server")
                
                self.persistenceLayer.update(post: post, with: remoteComments) { isSuccess in
                    print("Remote comments \(isSuccess ? "successfully" : "could not be") saved into local warehouse")
                }
            }
        }
    }
    
    private func fetchCommentsFromAPI(for post: PostViewModelProtocol,
                                      completion: @escaping PostDataProviderCompletion<CommentViewModelProtocol>) {
        
        apiLayer.fetchComments(for: post) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let comments):
                completion(comments.map(CommentViewModel.init))
                
            case .failure(let error):
                self.apiErrorHandler.handleError(error)
            }
        }
    }
}
