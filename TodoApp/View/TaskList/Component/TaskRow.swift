//
//  TaskRow.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/24.
//
import SwiftUI

struct TaskRow: View {
    let task: Todo

    var body: some View {
        HStack {
            Image(systemName: "document.fill")
                .fontWeight(.bold)
                .foregroundColor(.secondary)

            Text(task.title)
                .font(.callout)
                .lineLimit(1)
                .truncationMode(.tail)

            Spacer()

            TaskStatusText(status: task.status, fontSize: .body)
                .layoutPriority(1)
        }
        .padding(.vertical, 1)
    }
}
