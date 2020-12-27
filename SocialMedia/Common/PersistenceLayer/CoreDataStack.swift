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

// MARK: - Core Data Create Methods -

extension CoreDataStack: PersistenceCreateLayerInterface {
    func save(posts: [PostViewModelProtocol],
              completion: ((_ isSuccess: Bool) -> Void)? = nil) {
        
        persistentContainer.performBackgroundTask { [weak self] backgroundContext in
            guard let self = self else { return }
            
            posts.forEach { post in
                Post.makeSelf(from: post, context: backgroundContext)
            }
            
            self.save(context: backgroundContext)
        }
    }
}

// MARK: - Core Data Read Methods -

extension CoreDataStack: PersistenceReadLayerInterface {
    func fetchPosts(completion: @escaping ([PostViewModelProtocol]) -> Void) {
        let request = Post.createFetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Post.postID, ascending: true)]
        
        persistentContainer.performBackgroundTask { [weak self] backgroundContext in
            guard let self = self else { return }
            completion((try? self.persistentContainer.viewContext.fetch(request)) ?? [])
        }
    }
    
    func fetchComments(for post: PostViewModelProtocol, completion: (([CommentViewModelProtocol]) -> Void)? = nil) {
        let request = Post.createFetchRequest()
        let predicate = NSPredicate(format: "postID = %d", post.postID)
        request.predicate = predicate
        
        persistentContainer.performBackgroundTask { backgroundContext in
            let managedPost = try? backgroundContext.fetch(request).first
            completion?(Array(managedPost?.postComments ?? []))
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
                let oldPost = Post.makeSelf(from: post, context: backgroundContext)
                
                managedPost.postComments = Set(comments.map { Comment.makeSelf(from: $0,
                                                                       in: oldPost,
                                                                       context: backgroundContext) })
                completion?(true)
                
            } else {
                completion?(false)
            }
            
            self.save(context: backgroundContext)
        }
    }
}
