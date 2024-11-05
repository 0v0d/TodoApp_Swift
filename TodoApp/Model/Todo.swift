//
//  Todo.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/24.
//
import Foundation
import SwiftData

@Model
final class Todo {
    var title: String
    var comment: String
    var timestamp: Date
    var dueDate: Date
    var status: Status

    init(title: String, comment: String, timestamp: Date, dueDate: Date, status: Status) {
        self.title = title
        self.comment = comment
        self.timestamp = timestamp
        self.dueDate = dueDate
    }
}
