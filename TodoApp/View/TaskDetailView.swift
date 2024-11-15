//
//  TaskDetailView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/27.
//
import SwiftUI

//TODO ファイル分けをする

struct TaskDetailViewOrEmpty: View {
    @Binding var selectedTask: Todo?
    let tasks: [Todo]
    
    var body: some View {
        if let task = selectedTask, tasks.contains(task) {
            TaskDetailView(task: task)
        } else {
            EmptyStateView(
                title: "SelectTask",
                systemImageName: "sidebar.right",
                description: "TaskSelectionMessage"
            )
        }
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

private struct InfoRow: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(LocalizedStringKey(title))
                .font(.caption)
                .foregroundColor(.secondary)
            
            if let url = URL(string: content),
               UIApplication.shared.canOpenURL(url) {
                HStack {
                    Link(content, destination: url)
                        .font(.body)
                        .foregroundColor(.blue)
                }
            } else {
                Text(content)
                    .font(.body)
                    .contextMenu {
                        Button(action: {
                            UIPasteboard.general.string = content
                        }) {
                            Text("Copy")
                            Image(systemName: "document.on.document")
                        }
                    }
            }
        }
    }
}

private struct StatusInfo: View {
    let title: String
    let status: TaskStatus
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(LocalizedStringKey(title))
                .font(.caption)
                .foregroundColor(.secondary)
            Text(LocalizedStringKey(status.title))
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
        url: "https://example.com",
        timestamp: Date(),
        dueDate: Date().addingTimeInterval(24 * 60 * 60),  // 明日の日付をテスト用に設定
        status: .inProgress,
        order: 0
    )
    TaskDetailView(task: testData)
}
