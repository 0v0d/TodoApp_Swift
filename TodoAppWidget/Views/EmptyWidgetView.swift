//
//  EmptyWidgetView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/27.
//
import SwiftUI

/// Todoが存在しない場合に表示される空の状態のビュー
///
/// このビューは以下の要素を中央に配置して表示します：
/// - トレイアイコン
/// - "Todoがありません"というメッセージ
///
/// - Note:
///  - このビューは自動的にローカライズされたテキストを使用します
struct EmptyWidgetView: View {

    var body: some View {
        VStack(spacing: 8) {
            /// トレイのアイコン
            Image(systemName: "tray.fill")
                .font(.system(size: 40))
                .foregroundColor(.secondary)

            /// Todoがありませんの表示
            Text(LocalizedStringKey("NoTodos"))
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
}
