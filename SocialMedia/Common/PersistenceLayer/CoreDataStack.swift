//
//  PersistenceLayer.swift
//  todo
//
//  Created by Okhan Okbay on 7.11.2020.
//

import Foundation
import CoreData

// MARK: - Core Data stack

final class CoreDataStack {
    static let shared: CoreDataStack = .init()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container: NSPersistentContainer = .init(name: "SocialMedia")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                self.handleError(error)
            }
        })
        return container
    }()
    
    init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(sceneDidEnterBackground),
                                               name: NotificationNameWrapper.sceneDidEnterBackground,
                                               object: nil)
    }
    
    @objc func sceneDidEnterBackground() {
        CoreDataStack.shared.saveContext()
    }
}

// MARK: - Core Data Saving support

extension CoreDataStack {
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                handleError(error)
            }
        }
    }
    
    private func handleError(_ error: Error) {
        fatalError("Unresolved error: \(error.localizedDescription)")
    }
}

// MARK: Core Data Helper Methods

extension CoreDataStack: PersistenceLayerInterface {
    func fetchPosts() -> [PostMediationProtocol] {
        let request = Post.createFetchRequest()
        return (try? persistentContainer.viewContext.fetch(request)) ?? []
    }
    
    func save(posts: [PostMediationProtocol]) {
        posts.forEach { post in
            let managedPost = Post(context: persistentContainer.viewContext)
            managedPost.postID = post.postID
            managedPost.title = post.title
            managedPost.body = post.body
            managedPost.name = post.name
            managedPost.username = post.username
            
            managedPost.comments = Set(post.allComments.map { comment in
                let managedComment = Comment(context: persistentContainer.viewContext)
                managedComment.postID = comment.postID
                managedComment.commentID = comment.commentID
                managedComment.name = comment.name
                managedComment.email = comment.email
                managedComment.body = comment.body
                managedComment.inPost = managedPost
                return managedComment
            })
        }
        
        saveContext()
    }
    
    func fetchComments(for postID: Int) -> [CommentMediationProtocol] {
        let request = Comment.createFetchRequest()
        let predicate = NSPredicate(format: "postID = %@", postID)
        request.predicate = predicate
        return (try? persistentContainer.viewContext.fetch(request)) ?? []
    }
}
