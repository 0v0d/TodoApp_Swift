//
//  EmptyStateView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/15.
//
import SwiftUI

/// リストや詳細画面が空の状態を表示するビュー
struct EmptyStateView: View {
    /// タイトル
    let title: String

    /// アイコン
    let iconName: String

    /// 説明文
    let description: String

    var body: some View {
        VStack {
            // アイコンを表示
            Image(systemName: iconName)
                .font(.largeTitle)
                .foregroundColor(.gray)

            // タイトルを表示（ローカライズ対応）
            Text(LocalizedStringKey(title))
                .font(.title)
                .padding(.top, 5) // 上部に余白を設定

            // 説明を表示（ローカライズ対応）
            Text(LocalizedStringKey(description))
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}
