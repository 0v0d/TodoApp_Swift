//
//  TaskListView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/28.
//
import SwiftUI
import SwiftData

struct TaskListView: View {
    @Environment(\.editMode) private var editMode
    let tasks: [Todo]
    let deleteTask: (IndexSet) -> Void
    let moveTask: (IndexSet, Int) -> Void
    @Binding var selectedTask: Todo?

    var body: some View {
        List(selection: $selectedTask) {
            ForEach(tasks) { task in
                NavigationLink(value: task) {
                    TaskRow(task: task)
                }
            }
            .onDelete(perform: deleteTask)
            .onMove(perform: editMode?.wrappedValue.isEditing == true ? moveTask : nil)
        }
        .overlay {
            if tasks.isEmpty {
                EmptyStateView(
                    title: "NoTasks",
                    systemImageName: "note.text",
                    description: "AddNewTaskMessage"
                )
            }
        }
    }
}

#Preview {
    TaskListView(
        tasks: TodoTestData.todos,
        deleteTask: { _ in },
        moveTask: { _, _ in },
        selectedTask: .constant(nil)
    )
}
