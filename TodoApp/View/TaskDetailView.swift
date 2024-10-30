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

struct EmptyTaskView: View {
    var body: some View {
        ContentUnavailableView(
            "タスクを選択してください",
            systemImage: "sidebar.right",
            description: Text("左側のリストからタスクを選択するか、新しいタスクを追加してください")
        )
    }
}

struct TaskDetailView: View {
    @Bindable var task: Todo
    @State private var showingEditTask = false
    
    var body: some View {
        Form {
            TaskInfoSection(task: task)
            TimestampSection(timestamp: task.timestamp)
        }
        .navigationBarTitle(task.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("編集") {
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

struct TaskInfoSection: View {
    let task: Todo
    
    var body: some View {
        Section(header: Text("タスク詳細")) {
            InfoRow(title: "タイトル", content: task.title)
            InfoRow(title: "コメント", content: task.comment)
        }
    }
}

struct TimestampSection: View {
    let timestamp: Date
    
    var body: some View {
        Section(header: Text("作成日時")) {
            Text(timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
        }
    }
}

struct InfoRow: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(content)
                .font(.body)
        }
    }
}

#Preview {
    let testData = Todo( title: "test", comment: "テスト", timestamp: Date())
    TaskDetailView(task: testData)
}
