//
//  PersistenceLayer.swift
//  ToDo
//
//  Created by Okhan Okbay on 8.11.2020.
//

import Foundation

#warning("TODO")
protocol TaskObject: AnyObject {
  var taskDescription: String { get set }
  var recordDate: Date { get set }
}

protocol PersistenceLayer: AnyObject {
  func fetch() -> [TaskObject]
  func save(text: String)
  func update(task: TaskObject, with text: String)
  func delete(task: TaskObject)
}
