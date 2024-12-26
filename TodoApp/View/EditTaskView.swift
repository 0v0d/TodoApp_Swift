//
//  EditTaskView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/28.
//
import SwiftUI

/// 編集対象のタスクを編集するための画面
///
/// - Parameters:
///  - viewModel: タスクを管理するビューモデルをEnvironmentObjectとして利用（`TaskViewModel`型）
///  - task: 編集対象のタスク（`Todo`型）
struct EditTaskView: View {

    @EnvironmentObject var viewModel: TaskViewModel

    @Bindable var task: Todo

    @State private var formData: TaskFormData

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
    }

    /// 編集されたタスクを保存する処理
    private func saveTask() {
        Task {

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
        }
    }
}

#Preview {
    // プレビューでEditTaskViewを表示
    EditTaskView(task: TodoTestData.todo)
}
