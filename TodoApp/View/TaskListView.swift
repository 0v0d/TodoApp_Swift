//
//  TaskListView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/28.
//
import SwiftUI
import SwiftData

struct TaskListView: View {
    let tasks: [Todo]
    let deleteTask: (IndexSet) -> ()
    let moveTask: (IndexSet, Int) -> ()
    @Binding var selectedTask: Todo?
    @Binding var showingAddTask: Bool
    
    var body: some View {
        List(selection: $selectedTask) {
            ForEach(tasks) { task in
                NavigationLink(value: task) {
                    TaskRow(task: task)
                }
            }
            .onDelete(perform: deleteTask)
            .onMove(perform: moveTask)
        }
        .navigationTitle("タスクリスト")
        .overlay {
            if tasks.isEmpty {
                EmptyStateView(
                    title: "タスクがありません",
                    systemImageName: "note.text",
                    description: "新しいタスクを追加してください"
                )
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: { showingAddTask = true }) {
                    Image(systemName: "square.and.pencil")
                        .accessibilityLabel("新規タスク")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
        }
    }
}

struct TaskRow: View {
    let task: Todo
    
    var body: some View {
        HStack {
            Image(systemName: "document.fill")
                .fontWeight(.bold)
                
            Text(task.title)
                .font(.headline)
                .lineLimit(1)
        }
    }
}

struct EmptyStateView: View {
    let title: String
    let systemImageName: String
    let description: String
    
    var body: some View {
        VStack {
            Image(systemName: systemImageName)
                .font(.largeTitle)
                .foregroundColor(.gray)
            Text(title)
                .font(.title)
                .padding(.top, 5)
            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

