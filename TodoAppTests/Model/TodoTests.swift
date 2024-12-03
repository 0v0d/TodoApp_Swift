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
        let todo = TestData.todo
        XCTAssertEqual(todo.title, TestData.todo.title)
        XCTAssertEqual(todo.comment, TestData.todo.comment)
        XCTAssertEqual(todo.url, TestData.todo.url)
        XCTAssertEqual(todo.timestamp, TestData.todo.timestamp)
        XCTAssertEqual(todo.dueDate, TestData.todo.dueDate)
        XCTAssertEqual(todo.status, TestData.todo.status)
        XCTAssertEqual(todo.order, TestData.todo.order)
    }

    func testTodoUpdate() {
        let todo = TestData.todos[0]
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
