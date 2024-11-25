//
//  TaskInfoSection.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/24.
//
import SwiftUI

struct TaskInfoSection: View {
    let task: Todo

    var body: some View {
        Section {
            InfoRow(title: "Title", content: task.title)
            StatusInfo(title: "Status", status: task.status)
            InfoRow(title: "Comment", content: task.comment)
            if !task.url.isEmpty {
                InfoRow(title: "URL", content: task.url)
            }
            InfoRow(
                title: "DueDate",
                content: task.dueDate?.formattedDateTime() ?? String(localized: "None")
            )
            InfoRow(
                title: "CreatedDate",
                content: task.timestamp.formattedDateTime()
            )
        }
    }
}
