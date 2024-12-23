//
//  TaskFormView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/24.
//
import SwiftUI

/// タスクのフォームを表示するビュー
struct TaskFormView: View {
    // このビューを閉じるために使用されるEnvironment変数
    @Environment(\.dismiss) private var dismiss

    // フォームデータを親ビューと共有するバインディングプロパティ
    @Binding var formData: TaskFormData

    // 上部のナビゲーションバーに表示されるタイトル
    var topBarTitle: String

    /// フォームの保存時に実行されるクロージャ
    var action: (() -> Void)

    /// 入力エラーチェック用の計算プロパティ
    private var isError: Bool {
        // エラー条件:
        // - タイトルが空や改行またはスペースのみ
        // - 期限が無効
        // - URLが無効
        formData.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            || !DateValidator().isDueDateValid(formData.dueDate)
            || (!formData.url.isEmpty && !URLValidator().isValid(formData.url))
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                // フォームのメインコンテンツ
                TaskFormContent(formData: $formData)
                    // ナビゲーションバーのタイトルを設定
                    .navigationTitle(LocalizedStringKey(topBarTitle))
                    // タイトル表示モードをインラインに設定
                    .navigationBarTitleDisplayMode(.inline)
                    // ナビゲーションバーのツールバーアイテムを追加
                    .toolbar {
                        formToolbar
                    }
            }
        }
    }

    // ツールバーの内容を定義
    private var formToolbar: some ToolbarContent {
        Group {
            // キャンセルボタンをナビゲーションバーに追加
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss() // ビューを閉じる
                }
                .foregroundColor(.blue) // ボタンの色を青に設定
            }

            // 保存ボタンをナビゲーションバーに追加
            ToolbarItem(placement: .primaryAction) {
                Button("Save") {
                    handleSaveAction() // 保存アクションを実行
                }
                // エラー時はボタンを無効化
                .disabled(isError)
                // エラー時はグレー、それ以外は青で表示
                .foregroundColor(isError ? .gray : .blue)
            }
        }
    }

    // 保存アクションの処理
    private func handleSaveAction() {
        // エラーがない場合のみ保存アクションを実行
        if !isError {
            action() // 保存時の外部クロージャを呼び出す
            dismiss() // ビューを閉じる
        }
    }
}

#Preview {
    // プレビュー用のデータとビュー
    @Previewable @State var formData = TaskFormData() // バインディングデータを初期化
    let action = {} // 空のアクション
    let topBarTitle = "NewTask" // プレビュー用のタイトル
    TaskFormView(
        formData: $formData, // フォームデータをバインド
        topBarTitle: topBarTitle, // タイトルを設定
        action: action // アクションを設定
    )
}
