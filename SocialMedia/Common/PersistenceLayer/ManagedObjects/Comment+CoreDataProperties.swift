//
//  Comment+CoreDataProperties.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//
//

import Foundation
import CoreData


extension Comment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comment> {
        return NSFetchRequest<Comment>(entityName: "Comment")
    }

    @NSManaged public var postID: Int64
    @NSManaged public var commentID: Int64
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var body: String?
    @NSManaged public var post: Post?

}

extension Comment : Identifiable {

}
