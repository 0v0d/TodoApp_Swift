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
    @State private var editedDueDate: Date
    @State private var isUpdating = false

    init(task: Todo) {
        self.task = task
        _editedTitle = State(initialValue: task.title)
        _editedComment = State(initialValue: task.comment)
        _editedDueDate = State(initialValue: task.dueDate)
    }
    
    var body: some View {
        TaskFormView(
            title: $editedTitle,
            comment: $editedComment,
            dueDate: $editedDueDate,
            topBarTitle: "タスクの編集",
            action: saveTask
        )
        .overlay {
            if isUpdating {
                ProgressView("Updating...")
            }
        }
    }
    
    private func saveTask() {
        Task{
            isUpdating = true
            let updatedTask = task
            updatedTask.title = editedTitle
            updatedTask.comment = editedComment
            updatedTask.dueDate = editedDueDate
            await viewModel.updateTask(updatedTask)
            isUpdating = false
        }
    }
}

#Preview {
    let testData = Todo(title: "タスクの編集", comment: "コメント",timestamp: Date(), dueDate: Date())
    EditTaskView(task: testData)
}
