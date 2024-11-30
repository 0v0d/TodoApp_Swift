//
//  TodoAppWidgetExtraLargeView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/30.
//
import SwiftUI

struct TodoAppWidgetExtraLargeView: View {
    let task: Todo

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // タイトルとステータス
            HStack(alignment: .center, spacing: 16) {
                InfoWidgetRow(title: "Title", content: task.title, icon: "doc.text")
                    .padding(.trailing, 16)
                StatusInfoWidgetRow(status: task.status, icon: "checkmark.circle.fill")
            }
            Divider()
            // 期限と作成日時
            HStack(alignment: .center, spacing: 16) {
                InfoWidgetRow(
                    title: "DueDate",
                    content: task.dueDate?.formattedDateTime() ?? String(localized: "None"),
                    icon: "calendar.badge.clock"
                )
                InfoWidgetRow(
                    title: "CreatedDate",
                    content: task.timestamp.formattedDateTime(),
                    icon: "calendar"
                )
            }
            Divider()
            // コメントとURL
            HStack(alignment: .center, spacing: 16) {
                InfoWidgetRow(
                    title: "Comment",
                    content: task.comment.isEmpty ? String(localized: "None") : task.comment,
                    icon: "text.bubble"
                )
                InfoWidgetRow(
                    title: "URL",
                    content: task.url.isEmpty ? String(localized: "None") : task.url,
                    icon: "link"
                )
            }
            Divider()
        }.padding()
    }
}
