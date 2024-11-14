//
//  Status.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/5.
//
import SwiftUICore

enum Status: Int, CaseIterable, Codable {
    case notStarted = 0
    case inProgress = 1
    case completed = 2
    
    // 表示用の文字列を取得するためのプロパティ
    var displayText: String{
        switch self {
        case .notStarted: return "NotStarted"
        case .inProgress: return "InProgress"
        case .completed: return "Completed"
        }
    }
    var color: Color {
        switch self {
        case .notStarted:
            return .gray
        case .inProgress:
            return .blue
        case .completed:
            return .green
        }
    }
}
