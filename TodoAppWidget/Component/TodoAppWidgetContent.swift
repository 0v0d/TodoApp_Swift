//
//  TodoAppWidgetContent.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/27.
//
import SwiftUI

struct TodoAppWidgetContent: View {
    let task: Todo
    var body: some View {
        Text(task.title)
            .font(.system(size: 16, weight: .semibold))
            .lineLimit(2)

        Text(LocalizedStringKey(task.status.title))
            .font(.system(size: 12, weight: .medium))
            .padding(8)
            .background(task.status.color.opacity(0.15))
            .foregroundColor(task.status.color)
            .clipShape(Capsule())

        if task.dueDate != nil {
            VStack(alignment: .leading) {
                Image(systemName: "calendar")
                    .foregroundColor(.secondary)
                    .imageScale(.medium)
                    .padding(.top, 2)

                Text(task.dueDate?.formattedDateTime() ?? String(localized: "None"))
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
        }
    }
}
