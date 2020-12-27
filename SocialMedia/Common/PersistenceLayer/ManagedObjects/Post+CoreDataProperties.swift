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

    @NSManaged public var userID: Int
    @NSManaged public var postID: Int
    @NSManaged public var body: String
    @NSManaged public var name: String
    @NSManaged public var title: String
    @NSManaged public var username: String
    @NSManaged public var postComments: Set<Comment>

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

extension Post: PostViewModelProtocol {
    var comments: [CommentViewModelProtocol] {
        return Array(postComments)
    }
    
    @discardableResult
    static func makeSelf(from post: PostViewModelProtocol, context: NSManagedObjectContext) -> Post {
        let managedPost = Post(context: context)
        
        managedPost.postID = post.postID
        managedPost.userID = post.userID
        managedPost.title = post.title
        managedPost.body = post.body
        managedPost.name = post.name
        managedPost.username = post.username
        
        managedPost.postComments = Set(post.comments.map { comment in
            return Comment.makeSelf(from: comment, context: context)
        })
        
        return managedPost
    }
}
