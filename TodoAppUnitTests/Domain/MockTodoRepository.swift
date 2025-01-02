//
//  MockTodoRepository.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/03.
//
import Foundation
@testable import TodoApp

class MockTodoRepository: TodoRepository {

    var todos: [Todo] = []
    var error: Error?

    func addTodo(_ todo: Todo) async throws {
        if let error = error {
            throw error
        }
        todos.append(todo)
    }

    func updateTodo(_ todo: Todo) async throws {
        if let error = error {
            throw error
        }
        if let index = todos.firstIndex(of: todo) {
            todos[index] = todo
        }
    }

    func fetchTodos() async throws -> [Todo] {
        if let error = error {
            throw error
        }
        return todos
    }

    func updateOrder(from source: Int, end destination: Int) async throws {
        if let error = error {
            throw error
        }
        let movedTodo = todos.remove(at: source)
        todos.insert(movedTodo, at: destination)
    }

    func deleteTodo(todoIndex: IndexSet) async throws {
        if let error = error {
            throw error
        }
        guard let index = todoIndex.first else { return }
        todos.remove(at: index)
    }

    func deleteAllTodos() async throws {
        if let error = error {
            throw error
        }
        todos.removeAll()
    }
}
