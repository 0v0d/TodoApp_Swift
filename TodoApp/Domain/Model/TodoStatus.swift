//
//  TodoStatus.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/5.
//
import SwiftUICore

enum TodoStatus: Int, CaseIterable, Codable {
    /// 未着手
    case notStarted

    /// 進行中
    case inProgress

    /// 完了
    case completed

    // 表示用の文字列を取得するためのプロパティ
    var title: String {
        switch self {
        case .notStarted: "NotStarted"
        case .inProgress: "InProgress"
        case .completed: "Completed"
        }
    }

    // 色を取得するためのプロパティ
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
