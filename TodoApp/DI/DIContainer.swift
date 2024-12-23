//
//  DIContainer.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/5.
//

/// DIを管理するクラス
final class DIContainer {
    /// DIContainerのシングルトンインスタンス
    static let shared = DIContainer()

    private init() {}

    // TaskRepositoryを生成
    private lazy var repository: TaskRepository = {
        do {
            return try TaskRepositoryIMPL()
        } catch {
            // エラーが発生した場合のフォールバック処理
            fatalError("Failed to initialize TaskRepository: \(error)")
        }
    }()

    /// TaskViewModelを生成
    ///
    /// - Returns: TaskViewModel
    func makeTaskViewModel() -> TaskViewModel {
        TaskViewModel(repository: repository)
    }

    /// TaskDetailViewModelを生成
    ///
    /// - Returns: TaskDetailViewModel
    func makeWidgetViewModel() -> WidgetTaskViewModel {
        WidgetTaskViewModel(repository: repository)
    }
}
