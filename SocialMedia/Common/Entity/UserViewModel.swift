//
//  UserViewModel.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 27.12.2020.
//

import Foundation

protocol UserViewModelProtocol {
    var userID: Int { get }
    var name: String { get }
    var username: String { get }
}

struct UserViewModel: UserViewModelProtocol {
    let userID: Int
    let name: String
    let username: String

    init(with userAPIResponse: UserAPIResponse) {
        userID = userAPIResponse.userID
        name = userAPIResponse.name
        username = userAPIResponse.username
    }

    init(userID: Int, name: String, username: String) {
        self.userID = userID
        self.name = name
        self.username = username
    }
}
