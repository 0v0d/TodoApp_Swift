//
//  TaskDetailView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/27.
//
import SwiftUI

struct TaskDetailView: View {
    let selectedTask: Todo
    @State private var showingEditTask = false

    var body: some View {
        Form {
            TaskInfoSection(task: selectedTask)
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
            EditTaskView(task: selectedTask)
        }
    }
}

#Preview {
    TaskDetailView(selectedTask: TodoTestData.todo)
}
