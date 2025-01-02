//
//  TodoTestData.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/24.
//
import Foundation

/// テスト用のTodoデータを提供する構造体
///
/// `Todo`オブジェクトをテストする際に使用する個別のTodoデータや
/// 複数のTodoを含む配列データのサンプルを提供します
struct TodoTestData {
    /// テスト用のTodoデータ
    static let todo = Todo(
        title: "test",
        comment: "TestComment",
        url: "https://www.google.co.jp/",
        timestamp: Date(),
        dueDate: Date().addingTimeInterval(24 * 60 * 60),  // 明日の日付をテスト用に設定
        status: .inProgress,
        order: 0
    )

    /// テスト用のTodo配列データ
    static let todos: [Todo] = [
        Todo(
            title: "Todo 1",
            comment: "Weekly team meeting preparation",
            url: "https://teamcollab.com/meetings/weekly",
            timestamp: Date(),
            dueDate: nil,
            status: .inProgress,
            order: 0
        ),
        Todo(
            title: "Todo 2",
            comment: "Client proposal draft",
            url: "https://projectmanager.net/proposals/draft",
            timestamp: Date(),
            dueDate: Date().addingTimeInterval(72 * 60 * 60),
            status: .notStarted,
            order: 1
        ),
        Todo(
            title: "Todo 3",
            comment: "Marketing campaign review",
            url: "https://marketingportal.org/campaigns/review",
            timestamp: Date(),
            dueDate: Date().addingTimeInterval(48 * 60 * 60),
            status: .completed,
            order: 2
        ),
        Todo(
            title: "Todo 4",
            comment: "Quarterly budget analysis",
            url: "https://financedashboard.com/budget/q2",
            timestamp: Date(),
            dueDate: Date().addingTimeInterval(24 * 60 * 60),
            status: .inProgress,
            order: 3
        ),
        Todo(
            title: "Todo 5",
            comment: "Product development sprint",
            url: "https://devtracker.io/sprints/current",
            timestamp: Date(),
            dueDate: Date().addingTimeInterval(120 * 60 * 60),
            status: .notStarted,
            order: 4
        ),
        Todo(
            title: "Todo 6",
            comment: "System infrastructure maintenance",
            url: "https://itservicemanager.net/maintenance/logs",
            timestamp: Date(),
            dueDate: nil,
            status: .inProgress,
            order: 5
        ),
        Todo(
            title: "Todo 7",
            comment: "Annual performance review preparation",
            url: "https://hrplatform.com/performance/reviews",
            timestamp: Date(),
            dueDate: Date().addingTimeInterval(96 * 60 * 60),
            status: .notStarted,
            order: 6
        )
    ]

    /// テスト用の完了済みTodo配列データ
    static let completeTodos: [Todo] = [
        Todo(
            title: "Todo 1",
            comment: "Comment 1",
            url: "",
            timestamp: Date(),
            dueDate: nil,
            status: .completed,
            order: 0
        ),
        Todo(
            title: "Todo 2",
            comment: "Comment 2",
            url: "https://www.google.co.jp/",
            timestamp: Date(),
            dueDate: Date().addingTimeInterval(48 * 60 * 60),
            status: .completed,
            order: 1
        )
    ]
}
