//
//  TodoTests.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/01.
//
import XCTest
@testable import TodoApp

final class TodoTests: XCTestCase {
    func testTodoInitialization() {
        let todo = TodoTestData.todo
        XCTAssertEqual(todo.title, TodoTestData.todo.title)
        XCTAssertEqual(todo.comment, TodoTestData.todo.comment)
        XCTAssertEqual(todo.url, TodoTestData.todo.url)
        XCTAssertEqual(todo.timestamp, TodoTestData.todo.timestamp)
        XCTAssertEqual(todo.dueDate, TodoTestData.todo.dueDate)
        XCTAssertEqual(todo.status, TodoTestData.todo.status)
        XCTAssertEqual(todo.order, TodoTestData.todo.order)
    }

    func testTodoUpdate() {
        let todo = TodoTestData.todos[0]
        let newDueDate = Date()
        todo.update(
            title: "Updated Task",
            comment: "Updated comment",
            url: "https://www.google.co.jp/",
            dueDate: newDueDate,
            status: .completed
        )
        XCTAssertEqual(todo.title, "Updated Task")
        XCTAssertEqual(todo.comment, "Updated comment")
        XCTAssertEqual(todo.url, "https://www.google.co.jp/")
        XCTAssertEqual(todo.dueDate, newDueDate)
        XCTAssertEqual(todo.status, .completed)
    }
}
