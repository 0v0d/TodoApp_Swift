//
//  InputField.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/23.
//
import SwiftUI

/// ユーザーがテキストを入力するためのフィールド
///
/// - Parameters:
///  - title: 入力フィールドのタイトル  (`String` 型)
///  - placeholder: プレースホルダーとして表示するテキスト (`String` 型)
///  - text: 入力値を保持するバインディングプロパティ (`Binding<String>` 型)
///  - isRequired: 入力フィールドが必須かどうかを示すフラグ (デフォルトはfalse) (`Bool` 型)
///  - lineLimitRange: 入力可能な行数の範囲を指定するオプション (nilの場合は1行固定) (`ClosedRange<Int>?` 型)
struct InputField: View {

    let title: String

    let placeholder: String

    @Binding var text: String

    var isRequired: Bool = false

    var lineLimitRange: ClosedRange<Int>?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                // タイトルテキストを表示
                Text(LocalizedStringKey(title))
                    .font(.headline)
                    .foregroundColor(.secondary)

                // 必須マークを表示する (isRequiredがtrueの場合のみ)
                if isRequired {
                    Text("*")
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }

            TextField(
                // プレースホルダーテキストを表示
                LocalizedStringKey(placeholder),
                text: $text,
                // lineLimitRangeが指定されている場合は縦方向に対応する
                axis: lineLimitRange == nil ? .horizontal : .vertical
            )
            .padding() // フィールド内の余白を設定
            .accessibilityLabel(title) // アクセシビリティラベルを設定
            .background(Color(.secondarySystemBackground)) // 背景色を設定
            .cornerRadius(15) // 角を丸くする
            .lineLimit(lineLimitRange ?? 5...10) // 入力可能な行数の範囲を設定
        }
    }
}
