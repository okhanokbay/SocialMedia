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
    func fetchUsers(completion: @escaping ResponseHandler<[UserAPIResponse]>)
    func fetchPosts(completion: @escaping ResponseHandler<[PostAPIResponse]>)
    func fetchComments(commentRequest: CommentAPIRequest, completion: @escaping ResponseHandler<[CommentAPIResponse]>)
}

final class APILayer: APILayerInterface {
    private let socialMediaAPI: MoyaProvider<SocialMediaEndpoint> = .init() // Initialize here to abstract Moya usage from the outer classes
    private let apiResponseHandler: APIResponseHandler
    
    init(apiResponseHandler: APIResponseHandler) {
        self.apiResponseHandler = apiResponseHandler
    }
    
    func fetchUsers(completion: @escaping ResponseHandler<[UserAPIResponse]>) {
        socialMediaAPI.request(.users,
                               completion: apiResponseHandler.handleResponse(with: completion,
                                                                             responseType: [UserAPIResponse].self))
    }
    
    func fetchPosts(completion: @escaping ResponseHandler<[PostAPIResponse]>) {
        socialMediaAPI.request(.posts,
                               completion: apiResponseHandler.handleResponse(with: completion,
                                                                             responseType: [PostAPIResponse].self))
    }
    
    func fetchComments(commentRequest: CommentAPIRequest, completion: @escaping ResponseHandler<[CommentAPIResponse]>) {
        socialMediaAPI.request(.comments(postID: commentRequest.postID),
                               completion: apiResponseHandler.handleResponse(with: completion,
                                                                             responseType: [CommentAPIResponse].self))
    }
}
