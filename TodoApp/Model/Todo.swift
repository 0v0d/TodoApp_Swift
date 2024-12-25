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
    /// タスクのタイトル
    var title: String

    /// タスクの詳細コメント
    var comment: String

    /// 関連するURL
    var url: String

    /// タスクの作成日時
    var timestamp: Date

    /// タスクの締切日（オプション）
    var dueDate: Date?

    /// タスクの現在の状態（例: 完了、進行中、保留など）
    var status: TaskStatus

    /// タスクの順序（並べ替え用）
    var order: Int

    /// 初期化メソッド
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

    /// タスクを更新するメソッド
    ///
    /// - Parameters:
    ///   - title: 新しいタイトル
    ///   - comment: 新しいコメント
    ///   - url: 新しいURL
    ///   - dueDate: 新しい締切日（任意）
    ///   - status: 新しいタスクの状態（例: 完了、進行中、保留など）
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
