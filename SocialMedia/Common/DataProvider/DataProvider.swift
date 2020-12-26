//
//  DataProvider.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//

import Foundation

final class DataProvider {
    private let apiLayer: APILayerInterface
    private let apiResponseHandler: APIResponseHandlerInterface
    private let apiErrorHandler: APIErrorHandlerInterface
    
    private let persistenceLayer: PersistenceLayerInterface
    
    init(apiLayer: APILayerInterface,
         apiResponseHandler: APIResponseHandlerInterface,
         apiErrorHandler: APIErrorHandlerInterface,
         persistenceLayer: PersistenceLayerInterface) {
        
        self.apiLayer = apiLayer
        self.apiResponseHandler = apiResponseHandler
        self.apiErrorHandler = apiErrorHandler
        
        self.persistenceLayer = persistenceLayer
    }
    
    func getPosts(completion: @escaping ([PostViewModel]?) -> Void) {
        
        let taskGroup = DispatchGroup()
        
        taskGroup.enter()
        apiLayer.getUsers { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let users):
                print(users)
                
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
                print(posts)
                
            case .failure(let error):
                self.apiErrorHandler.handleError(error)
            }
            
            taskGroup.leave()
        }
        
        taskGroup.notify(queue: .main) {
            // Two concurrent tasks are finished
        }
    }
}
