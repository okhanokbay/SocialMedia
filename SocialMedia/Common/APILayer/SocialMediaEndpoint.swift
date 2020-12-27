//
//  SocialMediaEndpoint.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//

import Foundation
import Moya

enum SocialMediaEndpoint: TargetType {
    case users
    case posts
    case comments(postID: Int)

    var baseURL: URL {
        return "https://jsonplaceholder.typicode.com"
    }

    var path: String {
        switch self {
        case .users:
            return "/users"

        case .posts:
            return "/posts"

        case .comments:
            return "/comments"
        }
    }

    var task: Task {
        switch self {
        case .users, .posts:
            return .requestPlain

        case .comments(let postID):
            return .requestParameters(parameters: ["postId": postID], encoding: URLEncoding.default)
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return Data() // No sample data provided right now
    }

    var headers: [String: String]? {
        return nil
    }
}
