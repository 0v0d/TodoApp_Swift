//
//  DIContainer.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/5.
//

/// アプリ全体で使用するシングルトンパターンの DI コンテナ
///
/// リポジトリや ViewModel のインスタンスを生成・管理し、依存関係を注入します
///
/// - `DIContainer.shared` からアクセス可能なシングルトン
/// - `TodoRepository` を 1 つのインスタンスとして共有
final class DIContainer {
    static let shared = DIContainer()

    /// プライベートイニシャライザ
    /// - シングルトンを保証するため、外部からのインスタンス生成を防ぐため
    private init() {}

    /// TodoRepository のインスタンスを管理
    ///
    /// `TodoRepositoryIMPL` を生成し、リポジトリとして使用します
    /// - Note: エラーが発生した場合、`fatalError` でアプリを終了します
    private lazy var repository: TodoRepository = {
        do {
            return try TodoRepositoryIMPL()
        } catch {
            // エラーが発生した場合のフォールバック処理
            fatalError("Failed to initialize TodoRepository: \(error)")
        }
    }()

    /// TodoViewModel を生成
    ///
    /// `TodoRepository` を使用して `HomeViewModel` のインスタンスを作成します
    /// - Returns: `HomeViewModel` のインスタンス
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(repository: repository)
    }

    /// TodoDetailViewModel を生成
    ///
    /// `TodoRepository` を使用して `WidgetTodoViewModel` のインスタンスを作成します
    /// - Returns: `WidgetTodoViewModel` のインスタンス
    func makeWidgetViewModel() -> WidgetTodoViewModel {
        WidgetTodoViewModel(repository: repository)
    }
}
