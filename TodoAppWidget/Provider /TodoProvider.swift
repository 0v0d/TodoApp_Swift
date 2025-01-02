//
//  TodoProvider.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/27.
//
import WidgetKit

/// ウィジェットのデータを提供し、更新を管理するプロバイダー
///
/// - アクティブなTodoの取得
/// - ウィジェットの更新スケジュール管理
/// - プレースホルダーとスナップショットの提供
///
/// - Note: 15分ごとに自動更新されます
struct TodoProvider: @preconcurrency TimelineProvider {

    /// タイムラインを取得し、次回の更新スケジュールを設定
    ///
    /// - Parameters:
    ///   - context: 現在のウィジェットのコンテキスト
    ///   - completion: タイムライン更新後に呼ばれるコールバック
    func getTimeline(in context: Context, completion: @escaping @Sendable (Timeline<TodoEntry>) -> Void) {
       Task {
            do {
                let viewModel = DIContainer.shared.makeWidgetViewModel()
                let todo = try await viewModel.fetchActiveTodo()

                let entry = TodoEntry(date: Date(), todo: todo)
                let nextUpdate = Date().addingTimeInterval(60 * 15)
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                completion(timeline)

                completion(timeline)
            } catch {
                let timeline = Timeline(
                    entries: [TodoEntry(date: Date(), todo: nil)],
                    policy: .atEnd
                )
                completion(timeline)
            }
        }
    }

    /// プレースホルダー表示用のエントリーを提供
    ///
    /// - Parameter context: 現在のウィジェットのコンテキスト
    /// - Returns: プレースホルダー表示用のエントリー
    @MainActor
    func placeholder(in context: Context) -> TodoEntry {
        TodoEntry(date: Date(), todo: TodoTestData.todos[0])
    }

    /// 現在の状態のスナップショットを提供
    ///
    /// - Parameters:
    ///  - context: 現在のウィジェットのコンテキスト
    ///  - completion: スナップショット取得後に呼ばれるコールバック
    @MainActor
    func getSnapshot(
        in context: Context,
        completion: @escaping (TodoEntry) -> Void
    ) {
        Task {
            do {
                let viewModel = DIContainer.shared.makeWidgetViewModel()
                let activeTodo = try await viewModel.fetchActiveTodo()
                let todo = TodoEntry(date: Date(), todo: activeTodo)
                completion(todo)
            } catch {
                completion(TodoEntry(date: Date(), todo: nil))
            }
        }
    }
}
