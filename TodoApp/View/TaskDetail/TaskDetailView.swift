//
//  TaskDetailView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/27.
//
import SwiftUI

struct TaskDetailView: View {
    @Binding var selectedTask: Todo?
    let tasks: [Todo]

    var body: some View {
        if let task = selectedTask, tasks.contains(task) {
            TaskDetailViewContent(task: task)
        } else {
            EmptyStateView(
                title: "SelectTask",
                systemImageName: "sidebar.right",
                description: "TaskSelectionMessage"
            )
        }
    }
}

#Preview {
    TaskDetailViewContent(task: TestData.todo)
}
