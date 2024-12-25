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
/// - `TaskRepository` を 1 つのインスタンスとして共有
final class DIContainer {
    /// シングルトンインスタンス
    static let shared = DIContainer()

    /// プライベートイニシャライザ
    /// - シングルトンを保証するため、外部からのインスタンス生成を防ぐため
    private init() {}

    /// TaskRepository のインスタンスを管理
    ///
    /// `TaskRepositoryIMPL` を生成し、リポジトリとして使用します
    /// - Note: エラーが発生した場合、`fatalError` でアプリを終了します
    private lazy var repository: TaskRepository = {
        do {
            return try TaskRepositoryIMPL()
        } catch {
            // エラーが発生した場合のフォールバック処理
            fatalError("Failed to initialize TaskRepository: \(error)")
        }
    }()

    /// TaskViewModel を生成
    ///
    /// `TaskRepository` を使用して `TaskViewModel` のインスタンスを作成します
    /// - Returns: `TaskViewModel` のインスタンス
    func makeTaskViewModel() -> TaskViewModel {
        TaskViewModel(repository: repository)
    }

    /// TaskDetailViewModel を生成
    ///
    /// `TaskRepository` を使用して `WidgetTaskViewModel` のインスタンスを作成します
    /// - Returns: `WidgetTaskViewModel` のインスタンス
    func makeWidgetViewModel() -> WidgetTaskViewModel {
        WidgetTaskViewModel(repository: repository)
    }
}
