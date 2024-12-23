//
//  NavigationButtons.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/22.
//
import SwiftUI

struct NavigationButtons: View {
    /// タスクリストが空かどうかを判定するフラグ
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
                /// ボタンが押されたとき、タスク追加画面を表示するようフラグをtrueに設定します。
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
