//
//  MockTodoStatus.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/17.
//

/// Todoのステータスを表す列挙型のモック
enum MockTodoStatus {
    case notStarted
    case inProgress
    case completed

    var title: String {
        switch self {
        case .notStarted:
            return "Not Started"
        case .inProgress:
            return "In Progress"
        case .completed:
            return "Completed"
        }
    }
}
