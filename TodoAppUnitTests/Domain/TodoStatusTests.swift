//
//  TodoStatusTests.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/01.
//
import XCTest
import SwiftUICore
@testable import TodoApp

final class TodoStatusTests: XCTestCase {
    func testTodoStatusTitles() {
        XCTAssertEqual(TodoStatus.notStarted.title, "NotStarted")
        XCTAssertEqual(TodoStatus.inProgress.title, "InProgress")
        XCTAssertEqual(TodoStatus.completed.title, "Completed")
    }

    func testTodoStatusColors() {
        XCTAssertEqual(TodoStatus.notStarted.color, Color.gray)
        XCTAssertEqual(TodoStatus.inProgress.color, Color.blue)
        XCTAssertEqual(TodoStatus.completed.color, Color.green)
    }
}
