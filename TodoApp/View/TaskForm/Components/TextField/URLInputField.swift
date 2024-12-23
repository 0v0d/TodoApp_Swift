//
//  URLInputField.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/23.
//
import SwiftUI

/// URL入力フィールド
struct URLInputField: View {
    @Binding var url: String // URLを管理するバインディング変数

    var body: some View {
        VStack(spacing: 4) {
            InputField(
                title: "URL",                // フィールドのタイトル
                placeholder: "EnterURL",     // プレースホルダー
                text: $url,                  // 入力されたURLの値
                isRequired: false,           // 必須ではない
                lineLimitRange: 1...3        // 行数の範囲を指定
            )

            // URLが入力されており、バリデーションに失敗した場合、エラーメッセージを表示
            if !url.isEmpty && !URLValidator().isValid(url) {
                ErrorLabel(message: "invalidURLMessage")
            }
        }
    }
}
