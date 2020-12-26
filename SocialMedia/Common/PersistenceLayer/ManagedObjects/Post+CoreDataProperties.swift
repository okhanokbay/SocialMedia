//
//  Post+CoreDataProperties.swift
//  SocialMedia
//
//  Created by Okhan Okbay on 26.12.2020.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var postID: Int64
    @NSManaged public var name: Int64
    @NSManaged public var title: Int64
    @NSManaged public var body: Int64
    @NSManaged public var username: String?
    @NSManaged public var comments: NSSet?

}

// MARK: Generated accessors for comments
extension Post {

    @objc(addCommentsObject:)
    @NSManaged public func addToComments(_ value: Comment)

    @objc(removeCommentsObject:)
    @NSManaged public func removeFromComments(_ value: Comment)

    @objc(addComments:)
    @NSManaged public func addToComments(_ values: NSSet)

    @objc(removeComments:)
    @NSManaged public func removeFromComments(_ values: NSSet)

}

extension Post : Identifiable {

}
