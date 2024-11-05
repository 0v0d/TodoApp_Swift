//
//  HomeView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/28.
//
import SwiftUI
import SwiftData

struct HomeView: View {
    @EnvironmentObject var viewModel: TaskViewModel
    @State private var selectedTask: Todo? = nil
    @State private var showingAddTask = false
    @State private var columnVisibility = NavigationSplitViewVisibility.doubleColumn
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            TaskListView(
                tasks: viewModel.tasks,
                deleteTask: deleteTask,
                selectedTask: $selectedTask,
                showingAddTask: $showingAddTask
            )
            .navigationSplitViewColumnWidth(min: 150, ideal: 300, max: 400)
        } detail: {
            TaskDetailViewOrEmpty(selectedTask: $selectedTask, tasks: viewModel.tasks)
        }
        .sheet(isPresented: $showingAddTask) {
            AddTaskView()
        }
        .onAppear {
            loadTasks()
        }
    }
    
    private func loadTasks() {
        Task {
            await viewModel.loadTasks()
        }
    }
    
    private func deleteTask(offsets: IndexSet) {
        Task {
            for index in offsets {
                let task = viewModel.tasks[index]
                await viewModel.deleteTask(task)
            }
        }
    }
}


#Preview {
    HomeView()
}
