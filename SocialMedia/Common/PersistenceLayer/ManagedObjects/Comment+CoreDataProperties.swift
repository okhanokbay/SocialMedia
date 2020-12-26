//
//  Comment+CoreDataProperties.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 27.12.2020.
//
//

import Foundation
import CoreData

extension Comment {
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Comment> {
        return NSFetchRequest<Comment>(entityName: "Comment")
    }

    @NSManaged public var body: String
    @NSManaged public var commentID: Int
    @NSManaged public var email: String
    @NSManaged public var name: String
    @NSManaged public var postID: Int
    @NSManaged public var inPost: Post
}

extension Comment: CommentMediationProtocol {
    
}
