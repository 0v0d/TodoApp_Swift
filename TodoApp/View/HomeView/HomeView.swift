//
//  HomeView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/28.
//
import SwiftUI
import SwiftData

/// アプリのメイン画面（ホーム画面）
struct HomeView: View {
    /// タスクデータを管理するViewModel
    @EnvironmentObject var viewModel: TaskViewModel

    /// 現在選択されているタスク
    @State private var selectedTask: Todo?

    /// タスク追加画面を表示するためのフラグ
    @State private var showingAddTask = false

    /// ナビゲーションの列の表示状態
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
