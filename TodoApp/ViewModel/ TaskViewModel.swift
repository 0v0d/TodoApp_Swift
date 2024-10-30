//
//   TaskViewModel.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/30.
//
import Foundation

final class TaskViewModel: ObservableObject {
    private let repository: TaskRepository
    @Published var tasks: [Todo] = []
    @Published var errorMessage: String?
    
    init(repository: TaskRepository) {
        self.repository = repository
    }
    
    @MainActor
    func addTask(_ task: Todo) async {
        do {
            try await repository.addTask(task)
            await loadTasks()  // 重複を避ける
        } catch {
            handle(error: error)
        }
    }
    
    @MainActor
    func updateTask(_ task: Todo) async {
        do {
            try await repository.updateTask(task)
            await loadTasks()  // 重複を避ける
        } catch {
            handle(error: error)
        }
    }
    
    @MainActor
    func loadTasks() async {
        do {
            tasks = try await repository.fetchTasks()
        } catch {
            handle(error: error)
        }
    }
    
    
    @MainActor
    func deleteTask(_ task: Todo) async {
        do {
            // すべてのタスクを取得し、削除対象のタスクのインデックスを探す
            let allTasks = try await repository.fetchTasks()
            if let index = allTasks.firstIndex(of: task) {
                // 見つかったインデックスを IndexSet に変換
                let taskIndex = IndexSet(integer: index)
                // インデックスを渡して削除処理を実行
                try await repository.deleteTask(taskIndex: taskIndex)
                // 更新処理
                await loadTasks()
            }
        } catch {
            handle(error: error)
        }
    }

    
    private func handle(error: Error) {
        errorMessage = (error as? TaskRepositoryError)?.errorDescription ?? "予期しないエラーが発生しました。"
    }
}
