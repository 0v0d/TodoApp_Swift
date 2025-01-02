//
//  TodoFormDataTests.swift
//  TodoAppTests
//
//  Created by 0v0 on 2024/12/01.
//
import XCTest
@testable import TodoApp

final class TodoFormDataTests: XCTestCase {
    func testTodoFormDataDefaultInitialization() {
        let todoFormData = TodoFormData()
        XCTAssertEqual(todoFormData.title, "")
        XCTAssertEqual(todoFormData.comment, "")
        XCTAssertEqual(todoFormData.url, "")
        XCTAssertNil(todoFormData.dueDate)
        XCTAssertEqual(todoFormData.status, 0)
    }

    func testTodoFormDataInitializationFromTodo() {
        let todo = TodoTestData.todo
        let todoFormData = TodoFormData(from: todo)
        XCTAssertEqual(todoFormData.title, todo.title)
        XCTAssertEqual(todoFormData.comment, todo.comment)
        XCTAssertEqual(todoFormData.url, todo.url)
        XCTAssertEqual(todoFormData.dueDate, todo.dueDate)
        XCTAssertEqual(todoFormData.status, todo.status.rawValue)
    }
}
