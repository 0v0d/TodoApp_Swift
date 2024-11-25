//
//  TaskFormData.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/14.
//
import Foundation

struct TaskFormData {
    var title: String = ""
    var comment: String = ""
    var url: String = ""
    var dueDate: Date?
    var selectedValue: Int = 0

    init(from todo: Todo? = nil) {
        if let todo = todo {
            self.title = todo.title
            self.comment = todo.comment
            self.url = todo.url
            self.dueDate = todo.dueDate
            self.selectedValue = todo.status.rawValue
        }
    }
}
