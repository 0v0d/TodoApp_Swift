//
//  DIContainer.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/5.
//

final class DIContainer {
    static let shared = DIContainer()

    private init() {}

    // 必要な時にインスタンス化
    private lazy var repository: TaskRepository = {
        do {
            return try TaskRepositoryIMPL()
        } catch {
            // エラーが発生した場合のフォールバック処理
            fatalError("Failed to initialize TaskRepository: \(error)")
        }
    }()

    func makeTaskViewModel() -> TaskViewModel {
        TaskViewModel(repository: repository)
    }
}
