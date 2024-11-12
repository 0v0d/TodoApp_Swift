//
//  AddTask.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/24.
//
import SwiftUI

struct AddTaskView: View {
    @EnvironmentObject var viewModel: TaskViewModel
    @State private var title: String = ""
    @State private var comment: String = ""
    @State private var dueDate: Date? = nil
    @State private var selectedValue = 0
    @State private var isUpdating = false
    
    var body: some View {
        TaskFormView(
            title: $title,
            comment: $comment,
            dueDate: $dueDate,
            selectedValue: $selectedValue,
            topBarTitle: "新規タスク",
            action: addItem)
        .overlay {
            if isUpdating {
                ProgressView("Updating...")
            }
        }
    }

    private func addItem() {
        Task{
            isUpdating = true
            let task = Todo(
             title: title,
             comment: comment,
             timestamp: Date(), 
             dueDate: dueDate, 
             status: Status(rawValue: selectedValue) ?? .notStarted,
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
