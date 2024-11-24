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
    var url: String
    var timestamp: Date
    var dueDate: Date?
    var status: TaskStatus
    var order: Int

    init(
        title: String,
        comment: String,
        url: String,
        timestamp: Date,
        dueDate: Date?,
        status: TaskStatus,
        order: Int
    ) {
        self.title = title
        self.comment = comment
        self.url = url
        self.timestamp = timestamp
        self.dueDate = dueDate
        self.status = status
        self.order = order
    }

    // タスクを更新するメソッド
    func update(
        title: String,
        comment: String,
        url: String,
        dueDate: Date?,
        status: TaskStatus
    ) {
        self.title = title
        self.comment = comment
        self.url = url
        self.dueDate = dueDate
        self.status = status
    }
}
