//
//  TodoAppWidgetExtraLargeView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/30.
//
import SwiftUI

/// 最大サイズのウィジェットビュー
///
/// - タイトルとステータス
/// - 期限と作成日時
/// - コメントとURL
///
/// - Parameter todo: 表示するTodo情報 (`Todo` 型)
struct TodoAppWidgetExtraLargeView: View {

    let todo: Todo

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // タイトルとステータス
            HStack(alignment: .center, spacing: 16) {
                InfoWidgetRow(title: "Title", content: todo.title, iconName: "doc.text")
                    .padding(.trailing, 16)
                StatusInfoWidgetRow(status: todo.status, iconName: "checkmark.circle.fill")
            }
            Divider()

            // 期日と作成日時
            HStack(alignment: .center, spacing: 16) {
                InfoWidgetRow(
                    title: "DueDate",
                    content: todo.dueDate?.formattedDateTime() ?? String(localized: "None"),
                    iconName: "calendar.badge.clock"
                )
                InfoWidgetRow(
                    title: "CreatedDate",
                    content: todo.timestamp.formattedDateTime(),
                    iconName: "calendar"
                )
            }
            Divider()

            // コメントとURL
            HStack(alignment: .center, spacing: 16) {
                InfoWidgetRow(
                    title: "Comment",
                    content: todo.comment.isEmpty ? String(localized: "None") : todo.comment,
                    iconName: "text.bubble"
                )
                InfoWidgetRow(
                    title: "URL",
                    content: todo.url.isEmpty ? String(localized: "None") : todo.url,
                    iconName: "link"
                )
            }
            Divider()

        }.padding()
    }
}
