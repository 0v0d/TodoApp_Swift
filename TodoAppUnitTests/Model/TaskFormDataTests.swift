//
//  TaskFormDataTests.swift
//  TodoAppTests
//
//  Created by 0v0 on 2024/12/01.
//
import XCTest
@testable import TodoApp

final class TaskFormDataTests: XCTestCase {
    func testTaskFormDataDefaultInitialization() {
        let taskFormData = TaskFormData()
        XCTAssertEqual(taskFormData.title, "")
        XCTAssertEqual(taskFormData.comment, "")
        XCTAssertEqual(taskFormData.url, "")
        XCTAssertNil(taskFormData.dueDate)
        XCTAssertEqual(taskFormData.status, 0)
    }

    func testTaskFormDataInitializationFromTodo() {
        let todo = TodoTestData.todo
        let taskFormData = TaskFormData(from: todo)
        XCTAssertEqual(taskFormData.title, todo.title)
        XCTAssertEqual(taskFormData.comment, todo.comment)
        XCTAssertEqual(taskFormData.url, todo.url)
        XCTAssertEqual(taskFormData.dueDate, todo.dueDate)
        XCTAssertEqual(taskFormData.status, todo.status.rawValue)
    }
}
