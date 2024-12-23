//
//  TitleInputField.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/23.
//

import SwiftUI

/// タイトル入力フィールド
struct TitleInputField: View {
    /// タイトルを管理するバインディング変数
    @Binding var title: String

    var body: some View {
        InputField(
            title: "Title",                // フィールドのタイトル
            placeholder: "EnterTitle",     // プレースホルダー
            text: $title,                  // 入力されたタイトルの値
            isRequired: true,              // 必須フィールド
            lineLimitRange: 1...3          // 行数の範囲を指定
        )
    }
}
