//
//  TaskFormContent.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/24.
//
import SwiftUI

/// タスクの入力フォームを表示するビュー
struct TaskFormContent: View {
    /// タスクの入力フォームデータ
    @Binding var formData: TaskFormData

    var body: some View {
        VStack(spacing: 10) {
            // タイトル入力セクション
            TitleInputField(title: $formData.title)

            // コメント入力セクション
            CommentInputField(comment: $formData.comment)

            // URL入力セクション
            URLInputField(url: $formData.url)

            // ステータス選択セクション
            TaskStatusPickerSection(status: $formData.status)

            // 期日の入力セクション
            DueDatePickerSection(dueDate: $formData.dueDate)
        }.padding()
    }
}
