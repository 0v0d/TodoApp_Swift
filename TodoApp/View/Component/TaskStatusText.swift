//
//  TaskStatusText.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/27.
//
import SwiftUI

/// タスクのステータスを表示するビュー
///
/// このビューは、`TaskStatus` に基づいてタスクのステータスをテキストとして表示します
///
/// - Parameters:
///  - status: タスクのステータス（`TaskStatus` 型）
///    - `title`: ステータスのタイトル（`String` 型）
///    - `color`: ステータスの色（`Color` 型）
///  - fontSize: フォントサイズ（`Font` 型）
struct TaskStatusText: View {

    let status: TaskStatus

    let fontSize: Font

    var body: some View {

        Text(LocalizedStringKey(status.title))
            .font(fontSize) // 指定されたフォントサイズを適用
            .padding(.horizontal, 8) // 水平方向の余白
            .padding(.vertical, 6) // 垂直方向の余白
            .background(status.color.opacity(0.5)) // ステータスの色を背景色として設定（透過度50%）
            .clipShape(RoundedRectangle(cornerRadius: 10)) // 背景を丸みを帯びた矩形にする
    }
}
