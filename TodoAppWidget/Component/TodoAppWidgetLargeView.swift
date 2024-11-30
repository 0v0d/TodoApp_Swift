//
//  TodoAppWidgetLargeView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/29.
//
import SwiftUI

struct TodoAppWidgetLargeView: View {
    let task: Todo

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            InfoWidgetRow(title: "Title", content: task.title, icon: "doc.text")
            Divider()

            StatusInfoWidgetRow(status: task.status, icon: "checkmark.circle.fill")
            Divider()

            InfoWidgetRow(
                title: "DueDate",
                content: task.dueDate?.formattedDateTime() ?? String(localized: "None"),
                icon: "calendar.badge.clock"
            )
            Divider()

            InfoWidgetRow(
                title: "CreatedDate",
                content: task.timestamp.formattedDateTime(),
                icon: "calendar"
            )
        }
        .padding()
    }
}
