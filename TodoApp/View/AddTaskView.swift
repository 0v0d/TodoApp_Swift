//
//  AddTask.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/24.
//
import SwiftUI

struct AddTaskView: View {
    @EnvironmentObject var viewModel: TaskViewModel
    @State private var formData = TaskFormData()
    @State private var isUpdating = false
    
    var body: some View {
        TaskFormView(
            formData: $formData,
            topBarTitle: "NewTask",
            action: addItem)
        .overlay {
            if isUpdating {
                ProgressView("Updating")
            }
        }
    }

    private func addItem() {
        Task{
            isUpdating = true
            let task = Todo(
             title: formData.title,
             comment: formData.comment,
             url: formData.url,
             timestamp: Date(),
             dueDate: formData.dueDate, 
             status: TaskStatus(rawValue: formData.selectedValue) ?? .notStarted,
             order: viewModel.tasks.count
            )
            await viewModel.addTask(task)
            isUpdating = false
        }
    }
}

#Preview {
    AddTaskView()
}
