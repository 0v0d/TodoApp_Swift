//
//  TaskDetailViewContent.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/24.
//
import SwiftUI

struct TaskDetailViewContent: View {
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
