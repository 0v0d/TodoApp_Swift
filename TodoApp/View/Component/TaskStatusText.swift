//
//  TaskStatusText.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/27.
//
import SwiftUI

/// タスクのステータスを表示するビュー
/// このビューは、`TaskStatus` に基づいてタスクのステータスを表示します。
/// ステータス名を表示し、背景色やフォントサイズをカスタマイズできます。
struct TaskStatusText: View {
    /// タスクのステータス（`TaskStatus` 型）
    /// `TaskStatus` に応じて表示されるテキストや色を設定します。
    let status: TaskStatus

    /// フォントサイズ
    let fontSize: Font

    var body: some View {
        // ステータスのタイトルを表示（ローカライズ対応）
        Text(LocalizedStringKey(status.title))
            .font(fontSize)
            .padding(.horizontal, 8) // 水平方向の余白
            .padding(.vertical, 6) // 垂直方向の余白
            .background(status.color.opacity(0.5)) // ステータスの色を背景色として設定（透過度を50%に設定）
            .clipShape(RoundedRectangle(cornerRadius: 10)) // 背景を丸みを帯びた矩形にする
    }
}
