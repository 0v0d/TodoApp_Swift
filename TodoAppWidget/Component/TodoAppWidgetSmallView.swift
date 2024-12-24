//
//  TodoAppWidgetSmallView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/29.
//
import SwiftUI

/// 小サイズウィジェット用のタスク表示ビュー
///
/// このビューは以下の情報を表示します：
/// - タスクのタイトル
/// - タスクのステータス（完了、進行中、未着手）をアイコンと色で表現
///
/// ステータスの表示色：
/// - 完了: 緑色
/// - 進行中: 青色
/// - 未着手: グレー
///
/// - Parameter task: 表示するタスク情報
struct TodoAppWidgetSmallView: View {
    let task: Todo
    
    var body: some View {
        VStack(alignment: .leading) {
            InfoWidgetRow(
                title: "Title",
                content: task.title,
                iconName: "doc.text"
            )
            
            Divider()
            
            StatusInfoWidgetRow(
                status: task.status,
                iconName: "checkmark.circle.fill"
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

