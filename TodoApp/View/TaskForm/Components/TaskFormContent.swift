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
            TitleInputField(title: $formData.title)

            CommentInputField(comment: $formData.comment)

            URLInputField(url: $formData.url)

            TaskStatusPickerSection(status: $formData.status)

            DueDatePickerSection(dueDate: $formData.dueDate)
        }.padding()
    }
}
