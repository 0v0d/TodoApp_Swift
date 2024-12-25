//
//  TodoApp.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/24.
//
import SwiftUI

/// Todoアプリのエントリーポイント
///
/// - Note:
/// - エントリーポイントとして、`HomeView` を表示します
/// - `TaskViewModel` はDIコンテナから取得します
/// - `TaskViewModel` は `TaskRepository` を依存性として持ちます
@main
struct TodoApp: App {

    private let viewModel: TaskViewModel

    init() {
        viewModel = DIContainer.shared.makeTaskViewModel()
    }

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(viewModel)
        }
    }
}
