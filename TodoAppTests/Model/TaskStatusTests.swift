//
//  TaskStatusTests.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/01.
//
import XCTest
@testable import TodoApp
import SwiftUICore

final class TaskStatusTests: XCTestCase {
    func testTaskStatusTitles() {
        XCTAssertEqual(TaskStatus.notStarted.title, "NotStarted")
        XCTAssertEqual(TaskStatus.inProgress.title, "InProgress")
        XCTAssertEqual(TaskStatus.completed.title, "Completed")
    }

    func testTaskStatusColors() {
        XCTAssertEqual(TaskStatus.notStarted.color, Color.gray)
        XCTAssertEqual(TaskStatus.inProgress.color, Color.blue)
        XCTAssertEqual(TaskStatus.completed.color, Color.green)
    }
}
