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
    
    @State private var editedTitle: String
    @State private var editedComment: String
    @State private var editedDueDate: Date?
    @State private var selectedValue: Int
    @State private var isUpdating = false

    init(task: Todo) {
        self.task = task
        _editedTitle = State(initialValue: task.title)
        _editedComment = State(initialValue: task.comment)
        _editedDueDate = State(initialValue: task.dueDate)
        _selectedValue = State(initialValue: task.status.rawValue)
    }
    
    var body: some View {
        TaskFormView(
            title: $editedTitle,
            comment: $editedComment,
            dueDate: $editedDueDate,
            selectedValue: $selectedValue,
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
                title: editedTitle,
                comment: editedComment,
                dueDate: editedDueDate,
                status: Status(rawValue: selectedValue) ?? .notStarted
            )
            await viewModel.updateTask(task)
            isUpdating = false
        }
    }
}

#Preview {
    let testData = Todo(title: "NewTask", comment: "Comment",timestamp: Date(), dueDate: Date(), status: .inProgress, order: 1)
    EditTaskView(task: testData)
}
