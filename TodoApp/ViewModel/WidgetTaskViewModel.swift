//
//  WidgetTaskViewModel.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/26.
//

import Foundation

/// ウィジェット用のタスクビューモデル
///
/// - Note:
///  - タスクの状態が `completed` でない最初のタスクを取得します
///  - 期限日が設定されている場合は、期限日が近い順にソートされます
///  - 期限日が設定されていない場合は、作成日時が新しい順にソートされます
///  - 期限日が過去のタスクは取得されません
///  - タスクが存在しない場合は `nil` を返します
///  - インスタンスはDIContainerで生成されます
final class WidgetTaskViewModel {

    private let repository: TaskRepository

    /// 初期化メソッド
    /// - Parameter repository: タスクのデータを管理するリポジトリ
    init(repository: TaskRepository) {
        self.repository = repository
    }

    /// アクティブなタスクを取得する
    ///
    /// - Returns: アクティブなタスク（`Todo`） or `nil`
    func fetchActiveTask() async throws -> Todo? {
        let tasks = try await repository.fetchTasks()
        let activeTasks = tasks
            .filter { $0.status != .completed } // 完了していないタスクをフィルタリング
            .sorted { $0.dueDate ?? .distantFuture < $1.dueDate ?? .distantFuture } // 期限日が近い順にソート
        return activeTasks.first
    }
}
