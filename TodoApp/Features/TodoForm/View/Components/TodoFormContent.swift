//
//  TodoFormContent.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/24.
//
import SwiftUI

/// Todoの入力フォームを表示するビュー
///
/// - Parameter formData: Todoの入力データ（`TodoFormData` 型）
struct TodoFormContent: View {

    @Binding var formData: TodoFormData

    var body: some View {
        VStack(spacing: 10) {
            // タイトル入力セクション
            InputField(
                title: "Title",
                placeholder: "EnterTitle",
                text: $formData.title,
                isRequired: true,
                lineLimitRange: 1...3
            )

            // コメント入力セクション
            InputField(
                title: "Comment",
                placeholder: "EnterComment",
                text: $formData.comment,
                isRequired: false,
                lineLimitRange: 3...6
            )
            .padding(.top, 10) // 上部の余白を追加

            // URL入力セクション
            VStack(spacing: 4) {
                InputField(
                    title: "URL",
                    placeholder: "EnterURL",
                    text: $formData.url,
                    isRequired: false,
                    lineLimitRange: 1...3
                )

                // URLが入力されており、バリデーションに失敗した場合、エラーメッセージを表示
                if !formData.url.isEmpty && !URLValidator().isValid(formData.url) {
                    ErrorLabel(message: "invalidURLMessage")
                }
            }

            // ステータス選択セクション
            TodoStatusPickerSection(status: $formData.status)

            // 期日の入力セクション
            DueDatePickerSection(dueDate: $formData.dueDate)
        }.padding()
    }
}
