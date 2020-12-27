//
//  APIError.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//

import Foundation

enum APIError: Error {
  case decodingError(customDescription: String)
  case serverError(customDescription: String)

  var customDescription: String {
    switch self {
    case .decodingError(let customDescription), .serverError(let customDescription):
      return customDescription
    }
  }
}
