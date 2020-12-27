//
//  PersistenceLayer.swift
//  todo
//
//  Created by Okhan Okbay on 7.11.2020.
//

import Foundation
import CoreData

// MARK: - Core Data stack -

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
        CoreDataStack.shared.save(context: persistentContainer.viewContext)
    }
}

// MARK: - Core Data Saving support -

extension CoreDataStack {
    func save(context: NSManagedObjectContext) {
        if context.hasChanges {
            context.performAndWait { [weak self] in
                do {
                    try context.save()
                } catch {
                    self?.handleError(error)
                }
            }
        }
    }

    private func handleError(_ error: Error) {
        fatalError("Unresolved error: \(error.localizedDescription)")
    }
}

// MARK: - Core Data Create Methods -

extension CoreDataStack: PersistenceCreateLayerInterface {
    func save(posts: [PostViewModelProtocol],
              completion: ((_ isSuccess: Bool) -> Void)? = nil) {

        persistentContainer.performBackgroundTask { [weak self] backgroundContext in
            guard let self = self else {
                completion?(false)
                return
            }

            posts.forEach { post in
                Post.makeSelf(from: post, context: backgroundContext)
            }

            self.save(context: backgroundContext)
            completion?(true)
        }
    }
}

// MARK: - Core Data Read Methods -

extension CoreDataStack: PersistenceReadLayerInterface {
    func fetchPosts(completion: @escaping ([PostViewModelProtocol]) -> Void) {
        let request = Post.createFetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Post.postID, ascending: true)]

        persistentContainer.performBackgroundTask { backgroundContext in
            completion((try? backgroundContext.fetch(request)) ?? [])
        }
    }

    func fetchComments(for post: PostViewModelProtocol, completion: (([CommentViewModelProtocol]) -> Void)? = nil) {
        let request = Comment.createFetchRequest()
        let predicate = NSPredicate(format: "postID = %d", post.postID)
        request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Comment.commentID, ascending: true)]

        persistentContainer.performBackgroundTask { backgroundContext in
            let managedComments = try? backgroundContext.fetch(request)
            completion?(managedComments ?? [])
        }
    }
}

// MARK: - Core Data Update Methods -

extension CoreDataStack: PersistenceUpdateLayerInterface {
    func update(post: PostViewModelProtocol,
                with comments: [CommentViewModelProtocol],
                completion: ((_ isSuccess: Bool) -> Void)? = nil) {

        let request = Post.createFetchRequest()
        let predicate = NSPredicate(format: "postID = %d", post.postID)
        request.predicate = predicate

        persistentContainer.performBackgroundTask { backgroundContext in
            if let managedPost = try? backgroundContext.fetch(request).first {
                let newComments = Set(comments.map { Comment.makeSelf(from: $0, context: backgroundContext) })
                managedPost.postComments = newComments

                self.save(context: backgroundContext)
                completion?(true)

            } else {
                completion?(false)
            }
        }
    }
}
