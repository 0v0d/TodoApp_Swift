//
//  TodoAppWidgetLargeView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/29.
//
import SwiftUI

/// 大サイズウィジェット用のタスク表示ビュー
///
/// - タスクのタイトル
/// - タスクのステータス
/// - 期限
/// - 作成日時
///
/// - Parameter task: 表示するタスク情報 (`Todo` 型)
struct TodoAppWidgetLargeView: View {

    let task: Todo

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            InfoWidgetRow(title: "Title", content: task.title, iconName: "doc.text")
            Divider()

            StatusInfoWidgetRow(status: task.status, iconName: "checkmark.circle.fill")
            Divider()

            InfoWidgetRow(
                title: "DueDate",
                content: task.dueDate?.formattedDateTime() ?? String(localized: "None"),
                iconName: "calendar.badge.clock"
            )
            Divider()

            InfoWidgetRow(
                title: "CreatedDate",
                content: task.timestamp.formattedDateTime(),
                iconName: "calendar"
            )
        }
        .padding()
    }
}
