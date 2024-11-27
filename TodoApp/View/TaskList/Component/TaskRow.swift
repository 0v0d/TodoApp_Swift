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

            Text(task.title)
                .font(.callout)
                .lineLimit(1)

            Spacer()

            TaskStatusText(status: task.status, fontSize: .body)
        }
    }
}
