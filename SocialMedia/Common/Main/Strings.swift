//
//  Strings.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//

import Foundation

struct Strings {
    enum Alert: String {
        case error = "Error"
        case okay = "OK"
    }

    enum Post: String {
        case title = "Posts"
        case detailTitle = "Post Detail"

        case noComment = "No comments found for this post..."
        case commentsTitle = "Comments"
    }
}
