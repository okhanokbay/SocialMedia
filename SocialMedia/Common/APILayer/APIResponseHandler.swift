//
//  APIResponseHandler.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//

import Foundation
import Moya

protocol APIResponseHandlerInterface: AnyObject {
    func handleResponse<T: Decodable>(with completion: @escaping ResponseHandler<T>,
                                      responseType: T.Type) -> (Result<Response, MoyaError>) -> Void
}

final class APIResponseHandler: APIResponseHandlerInterface {
    func handleResponse<T: Decodable>(with completion: @escaping ResponseHandler<T>,
                                      responseType: T.Type) -> (Result<Response, MoyaError>) -> Void {
        
        return { result in
            switch result {
            case .success(let response):
                
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(decodedResponse))
                    
                } catch {
                    completion(.failure(.decodingError(customDescription: error.localizedDescription)))
                }
                
            case .failure(let error):
                completion(.failure(.serverError(customDescription: error.localizedDescription)))
            }
        }
    }
}
