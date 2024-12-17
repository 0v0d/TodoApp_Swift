//
//  MockTaskStatus.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/17.
//

enum MockTaskStatus{
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
