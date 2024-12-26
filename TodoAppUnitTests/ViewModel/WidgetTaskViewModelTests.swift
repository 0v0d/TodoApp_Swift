//
//  WidgetTaskViewModelTests.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/03.
//
import XCTest
@testable import TodoApp

/// `WidgetTaskViewModel` の動作を検証するテストクラス
///
/// このクラスでは、`WidgetTaskViewModel` が正しく動作するかをテストします
/// テストは非同期操作やエラーハンドリング、異なるタスク状態における動作をカバーします
final class WidgetTaskViewModelTests: XCTestCase {

    /// テスト対象のビューモデル
    private var viewModel: WidgetTaskViewModel!

    /// モックリポジトリ
    ///
    /// テスト用に注入されるリポジトリのモック実装
    /// タスクデータやエラーを注入することで、異なるシナリオをシミュレートします
    private let repository: MockTaskRepository = MockTaskRepository()

    /// 各テストのセットアップ処理
    ///
    /// テスト対象のビューモデルを初期化します
    override func setUp() {
        super.setUp()
        viewModel = WidgetTaskViewModel(repository: repository)
    }

    /// 各テストの後処理
    ///
    /// ビューモデルのインスタンスを破棄します
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    /// アクティブなタスクが存在する場合に正しいタスクを返すことを検証
    ///
    /// - 期待結果: 最も最近追加されたアクティブタスクが返される
    func testFetchActiveTaskWithActiveTasks() async throws {
        repository.tasks = TodoTestData.todos
        let activeTask = try await viewModel.fetchActiveTask()

        XCTAssertEqual(activeTask?.title, TodoTestData.todos[3].title)
    }

    /// 全てのタスクが完了状態の場合、`nil` を返すことを検証
    ///
    /// - 期待結果: アクティブタスクが存在しない場合に `nil` を返す
    func testFetchActiveTaskWithAllTasksCompleted() async throws {
        repository.tasks = TodoTestData.completeTodos
        let activeTask = try await viewModel.fetchActiveTask()
        XCTAssertNil(activeTask)
    }

    /// タスクが1件も存在しない場合に `nil` を返すことを検証
    ///
    /// - 期待結果: 空のタスクリストに対して `nil` を返す
    func testFetchActiveTaskWithNoTasks() async throws {
        repository.tasks = []
        let activeTask = try await viewModel.fetchActiveTask()
        XCTAssertNil(activeTask)
    }

    /// リポジトリがエラーをスローした場合のハンドリングを検証
    ///
    /// - 期待結果: リポジトリからのエラーが適切に伝播し、ビューが正しいエラー情報を受け取る
    func testFetchActiveTaskWhenRepositoryThrowsError() async {
        repository.error = NSError(
            domain: "TestError",
            code: 1,
            userInfo: [NSLocalizedDescriptionKey: "Fetch Error"])

        do {
            _ = try await viewModel.fetchActiveTask()
            XCTFail("Error")
        } catch {
            XCTAssertEqual((error as NSError).domain, "TestError")
            XCTAssertEqual((error as NSError).localizedDescription, "Fetch Error")
        }
    }
}
