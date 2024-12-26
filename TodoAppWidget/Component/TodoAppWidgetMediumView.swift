//
//  TodoAppWidgetMediumView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/30.
//
import SwiftUI

/// 中サイズウィジェット用のタスク表示ビュー
///
/// - タイトルとステータスを上部に横並びで表示
/// - 期限を下部に表示
///
/// - Parameter task: 表示するタスク情報 (`Todo` 型)
struct TodoAppWidgetMediumView: View {

    let task: Todo

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 16) {
                InfoWidgetRow(title: "Title", content: task.title, iconName: "doc.text")

                StatusInfoWidgetRow(status: task.status, iconName: "checkmark.circle.fill")
            }
            .padding(.horizontal)

            Divider()

            InfoWidgetRow(
                title: "DueDate",
                content: task.dueDate?.formattedDateTime() ?? String(localized: "None"),
                iconName: "calendar.badge.clock"
            )
            .padding(.horizontal)
        }
    }
}
