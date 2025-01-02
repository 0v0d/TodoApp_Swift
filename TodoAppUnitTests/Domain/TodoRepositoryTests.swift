//
//  TodoRepositoryTests.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/01.
//
import XCTest
import SwiftData
@testable import TodoApp

final class TodoRepositoryTests: XCTestCase {
    private var todoRepository: TodoRepositoryIMPL!

    override func setUp() async throws {
        todoRepository = try TodoRepositoryIMPL()
        try await todoRepository.deleteAllTodos()
    }

    override func tearDown() async throws {
        try await todoRepository.deleteAllTodos()
        todoRepository = nil
    }

    // 共通のタスク追加メソッド
    private func addTodos(_ todos: [Todo]) async throws {
        for todo in todos {
            try await todoRepository.addTodo(todo)
        }
    }

    func testAddTodo() async throws {
        try await todoRepository.addTodo(TodoTestData.todo)
        let todos = try await todoRepository.fetchTodos()
        XCTAssertEqual(todos.count, 1)
        XCTAssertEqual(todos, [TodoTestData.todo])
    }

    func testFetchTodos() async throws {
        try await addTodos(TodoTestData.todos)
        let todos = try await todoRepository.fetchTodos()
        XCTAssertEqual(todos.count, TodoTestData.todos.count)
        XCTAssertEqual(todos, TodoTestData.todos)
    }

    func testDeleteTodo() async throws {
        try await addTodos(TodoTestData.todos)
        let todos = try await todoRepository.fetchTodos()
        XCTAssertEqual(todos.count, TodoTestData.todos.count)

        try await todoRepository.deleteTodo(todoIndex: IndexSet(integer: 0))

        let updatedTodos = try await todoRepository.fetchTodos()
        XCTAssertEqual(updatedTodos.count, TodoTestData.todos.count - 1)
        for ite in 0..<updatedTodos.count {
            XCTAssertEqual(updatedTodos[ite], TodoTestData.todos[ite+1])
        }
    }

    func testUpdateTodo() async throws {
        let todo = TodoTestData.todo
        try await addTodos([todo])

        // タスクを更新
        todo.title = "Updated Todo"
        try await todoRepository.updateTodo(todo)

        let todos = try await todoRepository.fetchTodos()
        XCTAssertEqual(todos.count, 1)
        XCTAssertEqual(todos.first?.title, "Updated Todo")
    }

    func testUpdateOrderEdgeCase() async throws {
        try await addTodos(TodoTestData.todos)

        // 最後のタスクを最初に移動
        try await todoRepository.updateOrder(from: 2, end: 0)
        let todos = try await todoRepository.fetchTodos()

        XCTAssertEqual(todos.count, 7)
        XCTAssertEqual(todos, [
            TodoTestData.todos[2],
            TodoTestData.todos[0],
            TodoTestData.todos[1],
            TodoTestData.todos[3],
            TodoTestData.todos[4],
            TodoTestData.todos[5],
            TodoTestData.todos[6]
        ])
    }

}
