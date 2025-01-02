//
//  TodoRepository.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/22.
//
import Foundation

/// Todo管理機能を提供するリポジトリのプロトコル
///
/// リポジトリの具体的な実装に依存せずに、Todoの取得、追加、更新、削除、並び替えといった操作を行うために使用されます
///
/// - Note:
///  - すべてのメソッドは非同期で実行され、UI操作と連携しやすいよう`@MainActor`属性が付けられています
protocol TodoRepository {

    /// 全Todoを非同期で取得する
    ///
    /// データソース（例: ローカルデータベースやリモートAPI）から全てのTodoを取得します
    /// - Returns: 取得した`Todo`モデルの配列
    /// - Throws: データ取得に失敗した場合にエラーをスローします
    @MainActor func fetchTodos() async throws -> [Todo]

    /// 新しいTodoを追加する
    ///
    /// 指定された`Todo`オブジェクトをデータソースに保存します
    /// - Parameter todo: 追加するTodoの`Todo`オブジェクト
    /// - Throws: データ保存に失敗した場合にエラーをスローします
    @MainActor func addTodo(_ todo: Todo) async throws

    /// 既存のTodoを更新する
    ///
    /// 指定された`Todo`オブジェクトを元にTodoの内容を更新します
    /// - Parameter todo: 更新するTodoの`Todo`オブジェクト
    /// - Throws: データ更新に失敗した場合にエラーをスローします
    @MainActor func updateTodo(_ todo: Todo) async throws

    /// 指定したインデックスのTodoを削除する
    ///
    /// Todoのインデックスセットを指定して、対応するTodoをデータソースから削除します
    /// - Parameter todoIndex: 削除するTodoのインデックスを指定する`IndexSet`
    /// - Throws: データ削除に失敗した場合にエラーをスローします
    @MainActor func deleteTodo(todoIndex: IndexSet) async throws

    /// Todoの順序を更新する
    ///
    /// Todoの移動元と移動先のインデックスを指定して、Todoの並び順を変更します
    /// - Parameters:
    ///   - from: 移動元のインデックス
    ///   - end: 移動先のインデックス
    /// - Throws: 順序の更新に失敗した場合にエラーをスローします
    @MainActor func updateOrder(from: Int, end: Int) async throws

    /// 全てのTodoを削除する
    ///
    /// データソース内のすべてのTodoを削除します
    /// - Throws: データ削除に失敗した場合にエラーをスローします
    @MainActor func deleteAllTodos() async throws
}
