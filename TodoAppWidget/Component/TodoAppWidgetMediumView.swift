//
//  TodoAppWidgetMediumView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/30.
//
import SwiftUI

struct TodoAppWidgetMediumView: View {
    let task: Todo

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 16) {
                InfoWidgetRow(title: "Title", content: task.title, icon: "doc.text")

                StatusInfoWidgetRow(status: task.status, icon: "checkmark.circle.fill")
            }
            .padding(.horizontal)

            Divider()

            InfoWidgetRow(
                title: "DueDate",
                content: task.dueDate?.formattedDateTime() ?? String(localized: "None"),
                icon: "calendar.badge.clock"
            )
            .padding(.horizontal)
        }
    }
}
