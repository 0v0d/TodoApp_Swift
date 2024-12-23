//
//  CommentInputField.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/23.
//
import SwiftUICore

/// コメント入力フィールド
struct CommentInputField: View {
    /// コメントを管理するバインディング変数
    @Binding var comment: String

    var body: some View {
        InputField(
            title: "Comment",              // フィールドのタイトル
            placeholder: "EnterComment",   // プレースホルダー
            text: $comment,                // 入力されたコメントの値
            isRequired: false,             // 必須ではない
            lineLimitRange: 3...6          // 行数の範囲を指定
        )
        .padding(.top, 10) // 上部の余白を追加
    }
}
