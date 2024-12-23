//
//  EditTaskView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/28.
//
import SwiftUI

/// タスク編集画面
struct EditTaskView: View {
    /// タスクを管理するビューモデルをEnvironmentObjectとして利用
    @EnvironmentObject var viewModel: TaskViewModel

    /// 編集対象のタスクをBindableとして保持
    @Bindable var task: Todo

    /// フォームのデータを保持する状態変数
    @State private var formData: TaskFormData

    /// 更新中の状態を示すフラグ
    @State private var isUpdating = false

    /// 初期化時に編集対象のタスクをフォームデータに変換
    init(task: Todo) {
        self.task = task
        // タスクの内容を元に初期フォームデータを作成
        _formData = State(initialValue: TaskFormData(from: task))
    }

    var body: some View {
        // タスクフォームビューを利用してタスク編集画面を構築
        TaskFormView(
            formData: $formData, // フォームデータをバインド
            topBarTitle: "EditTask", // ナビゲーションバーに表示されるタイトル
            action: saveTask // 保存時のアクション
        )
        .overlay {
            // 更新中の状態を表示するオーバーレイ
            if isUpdating {
                ProgressView("Updating") // 更新中のスピナーとテキスト
            }
        }
    }

    /// 編集されたタスクを保存する処理
    private func saveTask() {
        Task {
            // 更新フラグを有効化
            isUpdating = true

            // フォームの内容をタスクに反映
            task.update(
                title: formData.title, // タスクのタイトル
                comment: formData.comment, // タスクのコメント
                url: formData.url, // タスクに関連付けられたURL
                dueDate: formData.dueDate, // タスクの期限日
                status: TaskStatus(rawValue: formData.status) ?? .notStarted // タスクのステータス
            )

            // ビューモデルを通じてタスクを非同期で更新
            await viewModel.updateTask(task)

            // 更新フラグを無効化
            isUpdating = false
        }
    }
}

#Preview {
    // プレビューでEditTaskViewを表示
    EditTaskView(task: TodoTestData.todo) // テスト用タスクデータを使用
}
