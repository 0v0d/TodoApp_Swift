//
//  TaskDetailView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/27.
//
import SwiftUI

struct TaskDetailViewOrEmpty: View {
    @Binding var selectedTask: Todo?
    let tasks: [Todo]
    
    var body: some View {
        if let task = selectedTask, tasks.contains(task) {
            TaskDetailView(task: task)
        } else {
            EmptyTaskView()
        }
    }
}

private struct EmptyTaskView: View {
    var body: some View {
        ContentUnavailableView(
            "SelectTask",
            systemImage: "sidebar.right",
            description: Text("TaskSelectionMessage")
        )
    }
}

private struct TaskDetailView: View {
    @Bindable var task: Todo
    @State private var showingEditTask = false
    
    var body: some View {
        Form {
            TaskInfoSection(task: task)
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Edit") {
                    showingEditTask = true
                }
                .foregroundColor(.blue)
            }
        }
        .sheet(isPresented: $showingEditTask) {
            EditTaskView(task: task)
        }
    }
}

private struct TaskInfoSection: View {
    let task: Todo
    
    var body: some View {
        Section {
            InfoRow(title: "Title", content: task.title)
            StatusInfo(title: "Status", status: task.status)
            InfoRow(title: "Comment", content: task.comment)
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

private struct InfoRow: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(LocalizedStringKey(title))
                .font(.caption)
                .foregroundColor(.secondary)
            Text(content)
                .font(.body)
        }
    }
}

private struct StatusInfo: View {
    let title: String
    let status: Status
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(LocalizedStringKey(title))
                .font(.caption)
                .foregroundColor(.secondary)
            Text(LocalizedStringKey(status.displayText))
                .font(.body)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(status.color.opacity(0.2))
                .foregroundColor(status.color)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

#Preview {
    let testData = Todo(
        title: "test",
        comment: "TestComment",
        timestamp: Date(),
        dueDate: Date().addingTimeInterval(24 * 60 * 60),  // 明日の日付をテスト用に設定
        status: .inProgress,
        order: 0
    )
    return TaskDetailView(task: testData)
}
