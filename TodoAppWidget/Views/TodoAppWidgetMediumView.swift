//
//  TodoAppWidgetMediumView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/30.
//
import SwiftUI

/// 中サイズウィジェット用のTodo表示ビュー
///
/// - タイトルとステータスを上部に横並びで表示
/// - 期限を下部に表示
///
/// - Parameter todo: 表示するTodo情報 (`Todo` 型)
struct TodoAppWidgetMediumView: View {

    let todo: Todo

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 16) {
                InfoWidgetRow(title: "Title", content: todo.title, iconName: "doc.text")

                StatusInfoWidgetRow(status: todo.status, iconName: "checkmark.circle.fill")
            }
            .padding(.horizontal)

            Divider()

            InfoWidgetRow(
                title: "DueDate",
                content: todo.dueDate?.formattedDateTime() ?? String(localized: "None"),
                iconName: "calendar.badge.clock"
            )
            .padding(.horizontal)
        }
    }
}
