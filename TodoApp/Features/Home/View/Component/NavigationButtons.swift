//
//  NavigationButtons.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/22.
//
import SwiftUI

/// Todoリスト画面のナビゲーションボタンを表示するビュー
///
/// このビューは、Todoリスト画面のナビゲーションバーに表示するボタンを提供します
///
/// - Parameters:
///  - isEmpty: Todoリストが空かどうかを判定するフラグ (`Bool`型)
///  - showingAddTodo: Todo追加画面を表示するためのバインディング変数 (`Bool`型)
///
/// - Note:
///  - Todoがない時は、Todo追加ボタンのみを表示します
///  - Todoがある時は、編集モード切り替えボタンとTodo追加ボタンを表示します
struct NavigationButtons: View {

    let isEmpty: Bool

    @Binding var showingAddTodo: Bool

    var body: some View {
        HStack {
            if !isEmpty {
                // 編集モードの切り替えボタン
                EditButton()
            }

            // Todo追加ボタン
            Button {
                /// ボタンが押されたとき、Todo追加画面を表示するようフラグをtrueに設定します
                showingAddTodo = true
            } label: {
                Image(systemName: "square.and.pencil")
                    .accessibilityLabel("NewTodo")
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
        }
    }
}
