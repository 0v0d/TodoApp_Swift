//
//  Status.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/5.
//

enum Status: Int, Codable {
    case notStarted = 0
    case inProgress = 1
    case completed = 2
    
    // 表示用の文字列を取得するためのプロパティ
    var displayText: String {
        switch self {
        case .notStarted: return "未着手"
        case .inProgress: return "進行中"
        case .completed: return "完了"
        }
    }
}