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
        }
        .navigationBarTitle(task.title)
        .navigationBarTitleDisplayMode(.large)
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
            InfoRow(title: "ステータス", content: task.status.displayText)
            InfoRow(title: "コメント", content: task.comment)
            InfoRow(
                title: "期日",
                content: task.dueDate.formattedDateTime()
            )
            InfoRow(
                title: "作成日時",
                content: task.timestamp.formattedDateTime()
            )
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
    let testData = Todo(
        title: "test",
        comment: "テスト",
        timestamp: Date(),
        dueDate: Date().addingTimeInterval(24 * 60 * 60),  // 明日の日付をテスト用に設定
        status: .inProgress,
        order: 0
    )
    return TaskDetailView(task: testData)
}
