//
//  TestHelper.swift
//  SocialMediaTests
//
//  Created by Okhan Okbay on 28.12.2020.
//

import Foundation

enum StubFilename: String {
    case posts = "PostsStubResponse"
    case users = "UsersStubResponse"
    case comments = "CommentsStubResponse"
}

class TestHelper {
    // swiftlint:disable force_try

    static func loadJSONFromFile<T: Decodable>(name: String) -> T {
        let bundle = Bundle(for: Self.self)
        let path = bundle.path(forResource: name, ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        return try! JSONDecoder().decode(T.self, from: data)
    }

    // swiftlint:enable force_try
}
