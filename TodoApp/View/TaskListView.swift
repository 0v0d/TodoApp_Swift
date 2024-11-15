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
    let deleteTask: (IndexSet) -> ()
    let moveTask: (IndexSet, Int) -> ()
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

private struct TaskRow: View {
    let task: Todo
    
    var body: some View {
        HStack {
            Image(systemName: "document.fill")
                .fontWeight(.bold)
            
            Text(task.title)
                .font(.callout)
                .lineLimit(1)
        }
    }
}
