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
///  - viewModel: Todoビューモデル（`TodoViewModel` 型）
///  - selectedTodo: 選択されたTodo（`Todo?` 型）
///  - showingAddTodo: Todo追加画面を表示するかどうか（`Bool` 型）
///  - columnVisibility: ナビゲーション分割ビューの列の表示状態（`NavigationSplitViewVisibility` 型）
///
/// - Note:
///  -  このビューは、Todoリストと詳細ビューを表示するメイン画面です
///  - SplitViewを使用して、左側にTodoリスト、右側に詳細ビューを表示します
///  - TodoリストからTodoを選択すると、詳細ビューに選択されたTodoの詳細が表示されます
///  - Todo追加画面を表示するためのボタンも含まれています
struct HomeView: View {

    @EnvironmentObject var viewModel: HomeViewModel

    @State private var selectedTodo: Todo?

    @State private var showingAddTodo = false

    @State private var columnVisibility =
        NavigationSplitViewVisibility.doubleColumn

    var body: some View {
        /// ナビゲーション分割ビュー（Todoリストと詳細表示を分割して表示）
        NavigationSplitView(columnVisibility: $columnVisibility) {
            // 左側のTodoリスト
            TodoListView(
                todos: viewModel.todos,
                deleteTodo: deleteTodo,
                moveTodo: moveTodo,
                selectedTodo: $selectedTodo
            )
            .navigationTitle("TodoList") // タイトル設定
            .navigationSplitViewColumnWidth(min: 150, ideal: 300, max: 400) // 列の幅設定
            .navigationBarItems(
                trailing: NavigationButtons(
                    isEmpty: viewModel.todos.isEmpty,
                    showingAddTodo: $showingAddTodo)
            )
            // 注: EditButtonのバグ回避のため、navigationBarItemsを使用
        } detail: {
            // 右側の詳細ビュー
            if let todo = selectedTodo {
                TodoDetailView(selectedTodo: todo) // 選択されたTodoの詳細を表示
            } else {
                // Todoが選択されていない場合の空の状態ビュー
                EmptyStateView(
                    title: "SelectTodo", // 空状態のタイトル
                    iconName: "sidebar.right", // アイコン
                    description: "TodoSelectionMessage" // 説明文
                )
            }
        }
        .sheet(isPresented: $showingAddTodo) {
            // Todo追加画面をモーダル表示
            AddTodoView()
        }
        .onAppear {
            // 画面表示時にTodoを読み込む
            loadTodos()
        }
    }
}

#Preview() {
    // プレビュー用の設定
    let viewModel = DIContainer.shared.makeHomeViewModel()
    HomeView()
        .environmentObject(viewModel)
}
