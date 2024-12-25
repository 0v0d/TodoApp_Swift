//
//  TaskRepository.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/22.
//
import Foundation

/// タスク管理機能を提供するリポジトリのプロトコル
///
/// リポジトリの具体的な実装に依存せずに、タスクの取得、追加、更新、削除、並び替えといった操作を行うために使用されます
///
/// - Note:
///  - すべてのメソッドは非同期で実行され、UI操作と連携しやすいよう`@MainActor`属性が付けられています
protocol TaskRepository {

    /// 全タスクを非同期で取得する
    ///
    /// データソース（例: ローカルデータベースやリモートAPI）から全てのタスクを取得します
    /// - Returns: 取得した`Todo`モデルの配列
    /// - Throws: データ取得に失敗した場合にエラーをスローします
    @MainActor func fetchTasks() async throws -> [Todo]

    /// 新しいタスクを追加する
    ///
    /// 指定された`Todo`オブジェクトをデータソースに保存します
    /// - Parameter task: 追加するタスクの`Todo`オブジェクト
    /// - Throws: データ保存に失敗した場合にエラーをスローします
    @MainActor func addTask(_ task: Todo) async throws

    /// 既存のタスクを更新する
    ///
    /// 指定された`Todo`オブジェクトを元にタスクの内容を更新します
    /// - Parameter task: 更新するタスクの`Todo`オブジェクト
    /// - Throws: データ更新に失敗した場合にエラーをスローします
    @MainActor func updateTask(_ task: Todo) async throws

    /// 指定したインデックスのタスクを削除する
    ///
    /// タスクのインデックスセットを指定して、対応するタスクをデータソースから削除します
    /// - Parameter taskIndex: 削除するタスクのインデックスを指定する`IndexSet`
    /// - Throws: データ削除に失敗した場合にエラーをスローします
    @MainActor func deleteTask(taskIndex: IndexSet) async throws

    /// タスクの順序を更新する
    ///
    /// タスクの移動元と移動先のインデックスを指定して、タスクの並び順を変更します
    /// - Parameters:
    ///   - from: 移動元のインデックス
    ///   - end: 移動先のインデックス
    /// - Throws: 順序の更新に失敗した場合にエラーをスローします
    @MainActor func updateOrder(from: Int, end: Int) async throws

    /// 全てのタスクを削除する
    ///
    /// データソース内のすべてのタスクを削除します
    /// - Throws: データ削除に失敗した場合にエラーをスローします
    @MainActor func deleteAllTasks() async throws
}
