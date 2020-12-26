//
//  Post+CoreDataProperties.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 27.12.2020.
//
//

import Foundation
import CoreData

extension Post {
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var body: String
    @NSManaged public var name: String
    @NSManaged public var postID: Int
    @NSManaged public var title: String
    @NSManaged public var username: String
    @NSManaged public var comments: Set<Comment>

}

// MARK: Generated accessors for comments
extension Post {

    @objc(addCommentsObject:)
    @NSManaged public func addToComments(_ value: Comment)

    @objc(removeCommentsObject:)
    @NSManaged public func removeFromComments(_ value: Comment)

    @objc(addComments:)
    @NSManaged public func addToComments(_ values: Set<Comment>)

    @objc(removeComments:)
    @NSManaged public func removeFromComments(_ values: Set<Comment>)
}

extension Post: PostMediationProtocol {
    var allComments: [CommentMediationProtocol] {
        return Array(comments)
    }
}
