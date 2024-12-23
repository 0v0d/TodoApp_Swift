//
//  AddTask.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/24.
//
import SwiftUI

/// タスク追加画面
struct AddTaskView: View {
    /// タスクを管理するビューモデルをEnvironmentObjectとして利用
    @EnvironmentObject var viewModel: TaskViewModel

    /// フォームデータを保持する状態変数
    @State private var formData = TaskFormData()

    /// 更新中の状態を示すフラグ
    @State private var isUpdating = false

    var body: some View {
        // タスクフォームビューを利用してタスク追加画面を構築
        TaskFormView(
            formData: $formData, // フォームの入力データをバインド
            topBarTitle: "NewTask", // 上部のナビゲーションバーに表示されるタイトル
            action: addItem // 保存時のアクションを設定
        )
        .overlay {
            // 更新中の状態を表示するオーバーレイ
            if isUpdating {
                ProgressView("Updating") // 更新中のスピナーとテキスト
            }
        }
    }

    /// フォームの内容を元にタスクを追加する処理
    private func addItem() {
        Task {
            // 更新フラグを有効化
            isUpdating = true

            // フォームデータからタスクを生成
            let task = Todo(
                title: formData.title, // タスクのタイトル
                comment: formData.comment, // タスクのコメント
                url: formData.url, // タスクに関連付けられたURL
                timestamp: Date(), // 作成日時を現在時刻に設定
                dueDate: formData.dueDate, // タスクの期限日
                status: TaskStatus(rawValue: formData.status) ?? .notStarted, // タスクのステータス
                order: viewModel.tasks.count // タスクの順序（既存タスク数を基に設定）
            )

            // ビューモデルを通じてタスクを非同期で追加
            await viewModel.addTask(task)

            // 更新フラグを無効化
            isUpdating = false
        }
    }
}

#Preview {
    // プレビューでAddTaskViewを表示
    AddTaskView()
}
