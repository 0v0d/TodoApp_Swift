//
//  TaskFormData.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/14.
//
import Foundation

/// Todoのデータをフォームで扱うための構造体
struct TaskFormData {
    /// タイトル（フォームのタイトルフィールド）
    var title: String = ""

    /// タスクの詳細コメント（フォームのコメントフィールド）
    var comment: String = ""

    /// 関連するURL（フォームのURLフィールド）
    var url: String = ""

    /// タスクの締切日（オプション。フォームの締切日フィールド）
    var dueDate: Date?

    /// タスクの現在の状態（例: 完了、進行中、保留など）
    /// - `0`: 未完了、`1`: 完了、など
    var status: Int = 0

    /// `Todo` モデルを元に初期化する
    ///
    /// - Parameter todo: `Todo` モデル（データがある場合のみ初期化）
    init(from todo: Todo? = nil) {
        // `Todo`の値がnil出ない時フォームデータに設定
        if let todo = todo {
            self.title = todo.title
            self.comment = todo.comment
            self.url = todo.url
            self.dueDate = todo.dueDate
            self.status = todo.status.rawValue // `status` は `Int` として格納
        }
    }
}
