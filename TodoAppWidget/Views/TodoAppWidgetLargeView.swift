//
//  TodoAppWidgetLargeView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/29.
//
import SwiftUI

/// 大サイズウィジェット用のTodo表示ビュー
///
/// - Todoのタイトル
/// - Todoのステータス
/// - 期限
/// - 作成日時
///
/// - Parameter todo: 表示するTodo情報 (`Todo` 型)
struct TodoAppWidgetLargeView: View {

    let todo: Todo

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            InfoWidgetRow(title: "Title", content: todo.title, iconName: "doc.text")
            Divider()

            StatusInfoWidgetRow(status: todo.status, iconName: "checkmark.circle.fill")
            Divider()

            InfoWidgetRow(
                title: "DueDate",
                content: todo.dueDate?.formattedDateTime() ?? String(localized: "None"),
                iconName: "calendar.badge.clock"
            )
            Divider()

            InfoWidgetRow(
                title: "CreatedDate",
                content: todo.timestamp.formattedDateTime(),
                iconName: "calendar"
            )
        }
        .padding()
    }
}
