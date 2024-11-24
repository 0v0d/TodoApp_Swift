//
//  EditTaskView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/28.
//
import SwiftUI

struct EditTaskView: View {
    @EnvironmentObject var viewModel: TaskViewModel
    
    @Bindable var task: Todo
    
    @State private var formData: TaskFormData
    @State private var isUpdating = false

    init(task: Todo) {
        self.task = task
        _formData = State(initialValue: TaskFormData(from:task))
    }
    
    var body: some View {
        TaskFormView(
            formData: $formData,
            topBarTitle: "EditTask",
            action: saveTask
        )
        .overlay {
            if isUpdating {
                ProgressView("Updating")
            }
        }
    }
    
    private func saveTask() {
        Task{
            isUpdating = true
            task.update(
                title: formData.title,
                comment: formData.comment,
                url: formData.url,
                dueDate: formData.dueDate,
                status: TaskStatus(rawValue: formData.selectedValue) ?? .notStarted
            )
            await viewModel.updateTask(task)
            isUpdating = false
        }
    }
}

#Preview {
    EditTaskView(task: TestData.todo)
}
