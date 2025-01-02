//
//  HomeViewModel.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/30.
//
import Foundation

/// Todoのデータを管理するためのビューモデル
///
/// - Parameter todos: Todoのリストを公開プロパティ (`[Todo]` 型)
///
/// - Note:
///  - Todoの追加、更新、削除、並び替えを行うためのメソッドを提供します
///  - Todoのリストを更新するために、リポジトリからデータを取得します
///  - エラーが発生した場合は、エラーログを出力します
///  - インスタンスはDIContainerで生成されます
final class HomeViewModel: ObservableObject {

    private let repository: TodoRepository

    @Published var todos: [Todo] = []

    /// 初期化メソッド
    /// - Parameter repository: Todoのデータを管理するリポジトリ
    init(repository: TodoRepository) {
        self.repository = repository
    }

    /// Todoを追加する非同期メソッド
    ///
    /// - Parameter todo: 追加するTodo
    @MainActor
    func addTodo(_ todo: Todo) async {
        do {
            // リポジトリを通じてTodoを追加
            try await repository.addTodo(todo)
            // Todoのリストを再読み込み
            await loadTodos()  // データ更新の冗長性を回避
        } catch {
            // エラーを処理
            handle(error: error)
        }
    }

    /// Todoを更新する非同期メソッド
    ///
    /// - Parameter todo: 更新するTodo
    @MainActor
    func updateTodo(_ todo: Todo) async {
        do {
            // リポジトリを通じてTodoを更新
            try await repository.updateTodo(todo)
            // Todoのリストを再読み込み
            await loadTodos()
        } catch {
            // エラーを処理
            handle(error: error)
        }
    }

    /// Todoを取得し、リストを更新する非同期メソッド
    @MainActor
    func loadTodos() async {
        do {
            // リポジトリからTodoのリストを取得
            todos = try await repository.fetchTodos()
        } catch {
            // エラーを処理
            handle(error: error)
        }
    }

    /// Todoの並び順を変更する非同期メソッド
    ///
    /// - Parameters:
    ///   - source: 元の位置
    ///   - destination: 移動先の位置
    @MainActor
    func moveTodo(from source: IndexSet, end destination: Int) async {
        do {
            // IndexSetから最初のインデックスを取得
            guard let sourceIndex = source.first else { return }
            // リポジトリで順序を更新
            try await repository.updateOrder(from: sourceIndex, end: destination)
            // Todoのリストを再読み込み
            await loadTodos()
        } catch {
            // エラーをログに記録
            handle(error: error)
        }
    }

    /// Todoを削除する非同期メソッド
    ///
    /// - Parameter todo: 削除するTodo
    @MainActor
    func deleteTodo(_ todo: Todo) async {
        do {
            // すべてのTodoを取得
            let allTodos = try await repository.fetchTodos()
            // 削除対象のTodoのインデックスを取得
            if let index = allTodos.firstIndex(of: todo) {
                // インデックスを IndexSet に変換
                let todoIndex = IndexSet(integer: index)
                // リポジトリで削除処理を実行
                try await repository.deleteTodo(todoIndex: todoIndex)
                // Todoのリストを再読み込み
                await loadTodos()
            }
        } catch {
            // エラーを処理
            handle(error: error)
        }
    }

    /// エラーを処理してエラーメッセージを設定
    ///
    /// - Parameter error: 発生したエラー
    /// - Note: エラーが頻繁に発生する場合は、UI側に表示するように変更
    private func handle(error: Error) {
        print("Error: \(error)")
    }
}
