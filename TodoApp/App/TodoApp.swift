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
/// - `HomeViewModel` はDIコンテナから取得します
/// - `HomeViewModel` は `TodoRepository` を依存性として持ちます
@main
struct TodoApp: App {

    private let viewModel: HomeViewModel

    init() {
        viewModel = DIContainer.shared.makeHomeViewModel()
    }

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(viewModel)
        }
    }
}
