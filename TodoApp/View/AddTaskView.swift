//
//  AddTask.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/24.
//
import SwiftUI

/// タスクの新規追加を行うための画面
///
/// - Parameter viewModel: タスクを管理するビューモデルをEnvironmentObjectとして利用（`TaskViewModel`型）
struct AddTaskView: View {
    @EnvironmentObject var viewModel: TaskViewModel

    @State private var formData = TaskFormData()

    var body: some View {
        // タスクフォームビューを利用してタスク追加画面を構築
        TaskFormView(
            formData: $formData, // フォームの入力データをバインド
            topBarTitle: "NewTask", // 上部のナビゲーションバーに表示されるタイトル
            action: addTask // 保存時のアクションを設定
        )
    }

    /// フォームの内容を元にタスクを追加する処理
    private func addTask() {
        Task {
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
        }
    }
}

#Preview {
    // プレビューでAddTaskViewを表示
    AddTaskView()
}
