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

        TaskStatusText(status: task.status, fontSize: .caption)

        if task.dueDate != nil {
            VStack(alignment: .leading) {
                Image(systemName: "calendar")
                    .foregroundColor(.secondary)
                    .imageScale(.medium)
                    .padding(.top, 2)

                Text(task.dueDate?.formattedDateTime() ?? "")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
        }
    }
}
