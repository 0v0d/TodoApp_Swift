//
//  TodoFormView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/24.
//
import SwiftUI

/// Todoの情報を入力するためのフォームビュー
///
/// - Parameters:
///  - dismiss: ビューを閉じるためのEnvironment変数
///  - formData: Todo情報を管理するバインディング変数 (`TodoFormData` 型)
///  - topBarTitle: ナビゲーションバーのタイトル (`String` 型)
///  - action: 保存アクション (`Void` を返すクロージャ)
///
/// - Note:
///  - フォームの保存時には、`action` で指定されたクロージャが実行されます
///  - 保存時にエラーがある場合は、保存アクションは実行されません
///    - エラー条件:
///     - タイトルが空や改行またはスペースのみ
///     - 期限が無効
///     - URLが無効
struct TodoFormView: View {

    @Environment(\.dismiss) private var dismiss

    @Binding var formData: TodoFormData

    var topBarTitle: String

    var action: (() -> Void)

    /// 入力エラーチェック用の計算プロパティ
    private var isError: Bool {
        formData.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            || !DateValidator().isDueDateValid(formData.dueDate)
            || (!formData.url.isEmpty && !URLValidator().isValid(formData.url))
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                // フォームのメインコンテンツ
                TodoFormContent(formData: $formData)
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
    @Previewable @State var formData = TodoFormData() // バインディングデータを初期化
    let action = {} // 空のアクション
    let topBarTitle = "NewItem" // プレビュー用のタイトル
    TodoFormView(
        formData: $formData, // フォームデータをバインド
        topBarTitle: topBarTitle, // タイトルを設定
        action: action // アクションを設定
    )
}
