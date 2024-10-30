//
//  TaskRepository.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/30.
//
import SwiftData
import Foundation

protocol TaskRepository {
    @MainActor func fetchTasks() async throws -> [Todo]
    @MainActor func addTask(_ task: Todo) async throws
    @MainActor func updateTask(_ task: Todo) async throws
    @MainActor func deleteTask(taskIndex: IndexSet) async throws
    @MainActor func deleteTask(_ task: Todo) async throws // 特定のタスクを削除するメソッド
}

final class TaskRepositoryIMPL: TaskRepository {
    private let modelContainer: ModelContainer

    init() throws {
        let schema = Schema([Todo.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            throw TaskRepositoryError.initializationError(error)
        }
    }

    @MainActor
    func fetchTasks() async throws -> [Todo] {
        let descriptor = FetchDescriptor<Todo>(sortBy: [SortDescriptor(\.timestamp, order: .reverse)])
        return try modelContainer.mainContext.fetch(descriptor)
    }
    
    @MainActor
    func addTask(_ task: Todo) async throws {
        modelContainer.mainContext.insert(task)
        try modelContainer.mainContext.save()
    }

    @MainActor
    func updateTask(_ task: Todo) async throws {
        try modelContainer.mainContext.save()
    }

    @MainActor
    func deleteTask(taskIndex: IndexSet) async throws {
        let allTasks = try await fetchTasks()
        for index in taskIndex {
            guard allTasks.indices.contains(index) else { continue }
            let taskToDelete = allTasks[index]
            modelContainer.mainContext.delete(taskToDelete)
        }
        try modelContainer.mainContext.save()
    }
    
    // 特定のタスクを削除するメソッド
    @MainActor
    func deleteTask(_ task: Todo) async throws {
        modelContainer.mainContext.delete(task)
        try modelContainer.mainContext.save()
    }
}


 enum TaskRepositoryError: LocalizedError {
    case initializationError(Error)
    case fetchError(Error)
    case addError(Error)
    case updateError(Error)
    case deleteError(Error)
    
    var errorDescription: String? {
        switch self {
        case .initializationError(let error):
            return "データベースの初期化に失敗しました: \(error.localizedDescription)"
        case .fetchError(let error):
            return "タスクの取得に失敗しました: \(error.localizedDescription)"
        case .addError(let error):
            return "タスクの追加に失敗しました: \(error.localizedDescription)"
        case .updateError(let error):
            return "タスクの更新に失敗しました: \(error.localizedDescription)"
        case .deleteError(let error):
            return "タスクの削除に失敗しました: \(error.localizedDescription)"
        }
    }
}
