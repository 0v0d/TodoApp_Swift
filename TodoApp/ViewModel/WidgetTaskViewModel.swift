//
//  WidgetTaskViewModel.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/26.
//

import Foundation

final class WidgetTaskViewModel {
    private let repository: TaskRepository

    init(repository: TaskRepository) {
        self.repository = repository
    }

    func fetchActiveTask() async throws -> Todo? {
        let tasks = try await repository.fetchTasks()
        let activeTasks = tasks
            .filter { $0.status != .completed }
            .sorted { $0.dueDate ?? .distantFuture < $1.dueDate ?? .distantFuture }
        return activeTasks.first
    }
}
