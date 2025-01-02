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
    /// Todoのタイトル
    var title: String

    /// Todoの詳細コメント
    var comment: String

    /// 関連するURL
    var url: String

    /// Todoの作成日時
    var timestamp: Date

    /// Todoの締切日（オプション）
    var dueDate: Date?

    /// Todoの現在の状態（例: 完了、進行中、保留など）
    var status: TodoStatus

    /// Todoの順序（並べ替え用）
    var order: Int

    /// 初期化メソッド
    init(
        title: String,
        comment: String,
        url: String,
        timestamp: Date,
        dueDate: Date?,
        status: TodoStatus,
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

    /// Todoを更新するメソッド
    ///
    /// - Parameters:
    ///   - title: 新しいタイトル
    ///   - comment: 新しいコメント
    ///   - url: 新しいURL
    ///   - dueDate: 新しい締切日（任意）
    ///   - status: 新しいTodoの状態（例: 完了、進行中、保留など）
    func update(
        title: String,
        comment: String,
        url: String,
        dueDate: Date?,
        status: TodoStatus
    ) {
        self.title = title
        self.comment = comment
        self.url = url
        self.dueDate = dueDate
        self.status = status
    }
}
