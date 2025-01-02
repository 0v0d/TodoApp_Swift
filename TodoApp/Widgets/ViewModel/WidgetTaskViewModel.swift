//
//  WidgetTodoViewModel.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/26.
//

import Foundation

/// ウィジェット用のTodoビューモデル
///
/// - Note:
///  - Todoの状態が `completed` でない最初のTodoを取得します
///  - 期限日が設定されている場合は、期限日が近い順にソートされます
///  - 期限日が設定されていない場合は、作成日時が新しい順にソートされます
///  - 期限日が過去のTodoは取得されません
///  - Todoが存在しない場合は `nil` を返します
///  - インスタンスはDIContainerで生成されます
final class WidgetTodoViewModel {

    private let repository: TodoRepository

    /// 初期化メソッド
    /// - Parameter repository: Todoのデータを管理するリポジトリ
    init(repository: TodoRepository) {
        self.repository = repository
    }

    /// アクティブなTodoを取得する
    ///
    /// - Returns: アクティブなTodo（`Todo`） or `nil`
    func fetchActiveTodo() async throws -> Todo? {
        let todos = try await repository.fetchTodos()
        let activeTodos = todos
            .filter { $0.status != .completed } // 完了していないTodoをフィルタリング
            .sorted { $0.dueDate ?? .distantFuture < $1.dueDate ?? .distantFuture } // 期限日が近い順にソート
        return activeTodos.first
    }
}
