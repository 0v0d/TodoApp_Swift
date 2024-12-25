//
//  ErrorLabel.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/15.
//
import SwiftUI

/// エラーメッセージを表示するためのビュー
///
/// - Parameters:
/// - `message`: エラーメッセージ（`LocalizedStringKey` 型）
///
/// - Note:
///  - エラーメッセージは赤色で表示されます
struct ErrorLabel: View {
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
