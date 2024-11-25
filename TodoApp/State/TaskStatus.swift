//
//  TaskStatus.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/5.
//
import SwiftUICore

enum TaskStatus: Int, CaseIterable, Codable {
    case notStarted
    case inProgress
    case completed

    // 表示用の文字列を取得するためのプロパティ
    var title: String {
        switch self {
        case .notStarted: "NotStarted"
        case .inProgress: "InProgress"
        case .completed: "Completed"
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
