//
//  TaskStatusTests.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/01.
//
import XCTest
import SwiftUICore
@testable import TodoApp

/// `TaskStatus` の動作を検証するテストクラス
///
/// このクラスでは、`TaskStatus` の `title` プロパティと `color` プロパティが
/// 各状態に応じて正しい値を持つかを検証します
final class TaskStatusTests: XCTestCase {

    /// `TaskStatus` のタイトルが正しい文字列を返すことを検証
    ///
    /// - 期待結果: 各タスクステータスの `title` が正しい値を返す
    func testTaskStatusTitles() {
        XCTAssertEqual(TaskStatus.notStarted.title, "NotStarted")
        XCTAssertEqual(TaskStatus.inProgress.title, "InProgress")
        XCTAssertEqual(TaskStatus.completed.title, "Completed")
    }

    /// `TaskStatus` のカラーが正しい値を返すことを検証
    ///
    /// - 期待結果: 各タスクステータスの `color` が正しい色を返す
    func testTaskStatusColors() {
        XCTAssertEqual(TaskStatus.notStarted.color, Color.gray)
        XCTAssertEqual(TaskStatus.inProgress.color, Color.blue)
        XCTAssertEqual(TaskStatus.completed.color, Color.green)
    }
}
