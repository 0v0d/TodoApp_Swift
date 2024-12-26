//
//  TaskViewModelTests.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/03.
//
import XCTest
@testable import TodoApp

/// `TaskViewModel` の動作を検証するテストクラス
///
/// このクラスでは、`TaskViewModel` が正しく動作することを検証します。
/// タスクの追加、読み込み、移動、削除など、主要な操作に関するテストを実施します。
final class TaskViewModelTests: XCTestCase {

    /// テスト対象のビューモデル
    private var viewModel: TaskViewModel!

    /// モックリポジトリ
    ///
    /// テスト用にタスクリポジトリをモック化したもの。
    /// タスクデータやエラーを注入することで、異なるシナリオをシミュレート可能です。
    private var repository: MockTaskRepository!

    /// 各テストのセットアップ処理
    ///
    /// テスト対象のビューモデルとモックリポジトリを初期化します。
    override func setUp() {
        super.setUp()
        repository = MockTaskRepository()
        viewModel = TaskViewModel(repository: repository)
    }

    /// 各テストの後処理
    ///
    /// ビューモデルとモックリポジトリのインスタンスを破棄します。
    override func tearDown() {
        viewModel = nil
        repository = nil
        super.tearDown()
    }

    /// タスクの追加が成功することを検証
    ///
    /// - 期待結果: タスクがリポジトリに正しく追加され、`viewModel.tasks` に反映される。
    func testAddTaskSuccess() async {
        let task = TodoTestData.todo

        await viewModel.addTask(task)

        XCTAssertEqual(viewModel.tasks.count, 1)
        XCTAssertEqual(viewModel.tasks.first?.title, TodoTestData.todo.title)
    }

    /// タスクの読み込みが成功することを検証
    ///
    /// - 期待結果: モックリポジトリ内のタスクが `viewModel.tasks` に正しく読み込まれる。
    func testLoadTasksSuccess() async {
        repository.tasks = TodoTestData.todos

        await viewModel.loadTasks()

        XCTAssertEqual(viewModel.tasks.count, TodoTestData.todos.count)
        XCTAssertEqual(viewModel.tasks[0].title, TodoTestData.todos[0].title)
    }

    /// タスクの並び替えが成功することを検証
    ///
    /// - 期待結果: 指定したインデックスからタスクを移動し、正しい順序でリストが更新される。
    func testMoveTaskSuccess() async {
        repository.tasks = TodoTestData.todos

        await viewModel.moveTask(from: IndexSet(integer: 0), end: 2)

        XCTAssertEqual(viewModel.tasks[0], TodoTestData.todos[1])
        XCTAssertEqual(viewModel.tasks[2], TodoTestData.todos[0])
    }

    /// タスクの削除が成功することを検証
    ///
    /// - 期待結果: 指定したタスクがリストから削除され、`viewModel.tasks` が更新される。
    func testDeleteTaskSuccess() async {
        repository.tasks = TodoTestData.todos

        await viewModel.deleteTask(repository.tasks[0])

        XCTAssertEqual(viewModel.tasks.count, TodoTestData.todos.count - 1)
        XCTAssertEqual(viewModel.tasks.first, TodoTestData.todos[1])
    }
}
