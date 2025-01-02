//
//  EmptyStateView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/15.
//
import SwiftUI

/// リストや詳細画面が空の状態を表示するビュー
///
/// このビューは、コンテンツが存在しない場合に 空の状態を示すために使用されます
///
/// - Parameters:
///  - title: 空の状態のタイトル(ローカライズ対応)　(`String`型)
///  - iconName: 空の状態を示すアイコン名　(`String`型)
///  - description: 空の状態の説明　(`String`型)
struct EmptyStateView: View {

    let title: String

    let iconName: String

    let description: String

    var body: some View {
        VStack {
            Image(systemName: iconName)
                .font(.largeTitle)
                .foregroundColor(.gray)

            Text(LocalizedStringKey(title))
                .font(.title)
                .padding(.top, 5)

            Text(LocalizedStringKey(description))
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}
