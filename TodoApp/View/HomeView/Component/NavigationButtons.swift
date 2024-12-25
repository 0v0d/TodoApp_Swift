//
//  NavigationButtons.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/22.
//
import SwiftUI

/// タスクリスト画面のナビゲーションボタンを表示するビュー
///
/// このビューは、タスクリスト画面のナビゲーションバーに表示するボタンを提供します
///
/// - Parameters:
/// - `isEmpty`: タスクリストが空かどうかを判定するフラグ (`Bool`型)
///
/// - Note:
///  - タスクがない時は、タスク追加ボタンのみを表示します
///  - タスクがある時は、編集モード切り替えボタンとタスク追加ボタンを表示します
struct NavigationButtons: View {

    let isEmpty: Bool

    /// タスク追加画面表示用のフラグ
    @Binding var showingAddTask: Bool

    var body: some View {
        HStack {
            if !isEmpty {
                // 編集モードの切り替えボタン
                EditButton()
            }

            // タスク追加ボタン
            Button {
                /// ボタンが押されたとき、タスク追加画面を表示するようフラグをtrueに設定します
                showingAddTask = true
            } label: {
                Image(systemName: "square.and.pencil")
                    .accessibilityLabel("NewTask")
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
        }
    }
}
