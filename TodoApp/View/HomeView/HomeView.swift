//
//  HomeView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/28.
//
import SwiftUI
import SwiftData

/// アプリのメイン画面（ホーム画面）
///
/// - Parameters:
///  - viewModel: タスクビューモデル（`TaskViewModel` 型）
///  - selectedTask: 選択されたタスク（`Todo?` 型）
///  - showingAddTask: タスク追加画面を表示するかどうか（`Bool` 型）
///  - columnVisibility: ナビゲーション分割ビューの列の表示状態（`NavigationSplitViewVisibility` 型）
///
/// - Note:
///  -  このビューは、タスクリストと詳細ビューを表示するメイン画面です
///  - SplitViewを使用して、左側にタスクリスト、右側に詳細ビューを表示します
///  - タスクリストからタスクを選択すると、詳細ビューに選択されたタスクの詳細が表示されます
///  - タスク追加画面を表示するためのボタンも含まれています
struct HomeView: View {

    @EnvironmentObject var viewModel: TaskViewModel

    @State private var selectedTask: Todo?

    @State private var showingAddTask = false

    @State private var columnVisibility =
        NavigationSplitViewVisibility.doubleColumn

    var body: some View {
        /// ナビゲーション分割ビュー（タスクリストと詳細表示を分割して表示）
        NavigationSplitView(columnVisibility: $columnVisibility) {
            // 左側のタスクリスト
            TaskListView(
                tasks: viewModel.tasks,
                deleteTask: deleteTask,
                moveTask: moveTask,
                selectedTask: $selectedTask
            )
            .navigationTitle("TaskList") // タイトル設定
            .navigationSplitViewColumnWidth(min: 150, ideal: 300, max: 400) // 列の幅設定
            .navigationBarItems(
                trailing: NavigationButtons(
                    isEmpty: viewModel.tasks.isEmpty,
                    showingAddTask: $showingAddTask)
            )
            // 注: EditButtonのバグ回避のため、navigationBarItemsを使用
        } detail: {
            // 右側の詳細ビュー
            if let task = selectedTask {
                TaskDetailView(selectedTask: task) // 選択されたタスクの詳細を表示
            } else {
                // タスクが選択されていない場合の空の状態ビュー
                EmptyStateView(
                    title: "SelectTask", // 空状態のタイトル
                    iconName: "sidebar.right", // アイコン
                    description: "TaskSelectionMessage" // 説明文
                )
            }
        }
        .sheet(isPresented: $showingAddTask) {
            // タスク追加画面をモーダル表示
            AddTaskView()
        }
        .onAppear {
            // 画面表示時にタスクを読み込む
            loadTasks()
        }
    }
}

#Preview() {
    // プレビュー用の設定
    let viewModel = DIContainer.shared.makeTaskViewModel()
    HomeView()
        .environmentObject(viewModel)
}
