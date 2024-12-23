//
//  ErrorLabel.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/15.
//
import SwiftUI

/// エラーメッセージを表示するビュー
struct ErrorLabel: View {
    /// エラーメッセージ (ローカライズ対応)
    let message: LocalizedStringKey

    var body: some View {
        HStack {
            Text(message)
                .font(.callout)
                .foregroundColor(.red) // 赤色で表示
            Spacer()
        }
        .padding(.leading, 16) // 左側に余白を設定
    }
}
