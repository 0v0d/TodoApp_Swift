//
//  TestData.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/24.
//
import Foundation

struct TestData {
    static let todo = Todo(
        title: "test",
        comment: "TestComment",
        url: "https://www.google.co.jp/",
        timestamp: Date(),
        dueDate: Date().addingTimeInterval(24 * 60 * 60),  // 明日の日付をテスト用に設定
        status: .inProgress,
        order: 0
    )

    // 複数のテストデータ
    static let todos: [Todo] = [
        Todo(
            title: "Task 1",
            comment: "Comment 1",
            url: "",
            timestamp: Date(),
            dueDate: nil,
            status: .inProgress,
            order: 0
        ),
        Todo(
            title: "Task 2",
            comment: "Comment 2",
            url: "https://www.google.co.jp/",
            timestamp: Date(),
            dueDate: Date().addingTimeInterval(48 * 60 * 60),
            status: .notStarted,
            order: 1
        )
    ]
}
