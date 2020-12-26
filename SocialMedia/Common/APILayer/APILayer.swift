//
//  APILayer.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//

import Foundation
import Moya

typealias ResponseHandler<ResponseType: Decodable> = (Result<ResponseType, APIError>) -> Void

protocol APILayerInterface: AnyObject {
    func getUsers(completion: @escaping ResponseHandler<[User]>)
    func getPosts(completion: @escaping ResponseHandler<[Post]>)
    func getComments(commentRequest: CommentRequest, completion: @escaping ResponseHandler<[Comment]>)
}

final class APILayer: APILayerInterface {
    private let socialMediaAPI: MoyaProvider<SocialMediaEndpoint> = .init() // Initialize here to abstract Moya usage from the outer classes
    private let apiResponseHandler: APIResponseHandler
    
    init(apiResponseHandler: APIResponseHandler) {
        self.apiResponseHandler = apiResponseHandler
    }
    
    func getUsers(completion: @escaping ResponseHandler<[User]>) {
        socialMediaAPI.request(.users,
                               completion: apiResponseHandler.handleResponse(with: completion,
                                                                             responseType: [User].self))
    }
    
    func getPosts(completion: @escaping ResponseHandler<[Post]>) {
        socialMediaAPI.request(.posts,
                               completion: apiResponseHandler.handleResponse(with: completion,
                                                                             responseType: [Post].self))
    }
    
    func getComments(commentRequest: CommentRequest, completion: @escaping ResponseHandler<[Comment]>) {
        socialMediaAPI.request(.comments(postID: commentRequest.postID),
                               completion: apiResponseHandler.handleResponse(with: completion,
                                                                             responseType: [Comment].self))
    }
}
