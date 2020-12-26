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
        let container: NSPersistentContainer = .init(name: "todo")
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

#warning("TODO")

// MARK: Core Data Helper Methods

//extension CoreDataStack: PersistenceLayer {
//    func fetch() -> [TaskObject] {
//        let request = Task.createFetchRequest()
//        request.sortDescriptors = [NSSortDescriptor(keyPath: \Task.recordDate, ascending: false)]
//        return (try? persistentContainer.viewContext.fetch(request)) ?? []
//    }
//
//    func save(text: String) {
//        let task = Task(context: persistentContainer.viewContext)
//        task.taskDescription = text
//        task.recordDate = Date()
//        saveContext()
//    }
//
//    func update(task: TaskObject, with text: String) {
//        task.taskDescription = text
//        task.recordDate = Date()
//        saveContext()
//    }
//
//    func delete(task: TaskObject) {
//        guard let task = task as? Task else {
//            return
//        }
//
//        persistentContainer.viewContext.delete(task)
//        saveContext()
//    }
//}
