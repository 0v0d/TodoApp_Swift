//
//  MockTaskRepository.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/03.
//

import Foundation
@testable import TodoApp

class MockTaskRepository: TaskRepository {

    var tasks: [Todo] = []
    var error: Error?

    func addTask(_ task: Todo) async throws {
        if let error = error {
            throw error
        }
        tasks.append(task)
    }

    func updateTask(_ task: Todo) async throws {
        if let error = error {
            throw error
        }
        if let index = tasks.firstIndex(of: task) {
            tasks[index] = task
        }
    }

    func fetchTasks() async throws -> [Todo] {
        if let error = error {
            throw error
        }
        return tasks
    }

    func updateOrder(from source: Int, end destination: Int) async throws {
        if let error = error {
            throw error
        }
        let movedTask = tasks.remove(at: source)
        tasks.insert(movedTask, at: destination)
    }

    func deleteTask(taskIndex: IndexSet) async throws {
        if let error = error {
            throw error
        }
        guard let index = taskIndex.first else { return }
        tasks.remove(at: index)
    }

    func deleteAllTasks() async throws {
        if let error = error {
            throw error
        }
        tasks.removeAll()
    }
}
