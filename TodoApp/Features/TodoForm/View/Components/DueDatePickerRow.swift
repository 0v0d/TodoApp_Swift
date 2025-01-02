//
//  DueDatePickerRow.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/25.
//
import SwiftUI

/// 期限日を選択するためのDatePickerを表示
///
/// - Parameters:
///  - dueDate: 期限日を管理するバインディング (`Date?` 型)
///  - title: 行のタイトル（例: 日付または時間） (`LocalizedStringKey`型)
///  - errorMessage: エラーメッセージ（バリデーション失敗時に表示） (`LocalizedStringKey`型)
///  - pickerTitle: DatePickerのタイトル（モーダルで表示されるラベル） (`LocalizedStringKey`型)
///  - isDatePicker: DatePickerが日付選択かどうかを指定 (`Bool`型)
///  - isError: エラーあるかどうか　(`Bool`型)
struct DueDatePickerRow: View {

    @Binding var dueDate: Date?

    let title: LocalizedStringKey

    let errorMessage: LocalizedStringKey

    let pickerTitle: LocalizedStringKey

    var isDatePicker: Bool = true

    let isError: Bool

    var body: some View {

        // 行のタイトルを表示
        Text(title)
            .font(.headline)
            .foregroundColor(.secondary)

        // バリデーションに失敗している場合にエラーメッセージを表示
        if isError {
            Text(errorMessage)
                .font(.headline)
                .foregroundColor(.red)
        }

        // 日付または時間を選択するDatePicker
        DatePicker(
            pickerTitle, // モーダルのタイトル
            selection: Binding(
                get: { dueDate ?? Date() }, // nilの場合は現在日時をデフォルトに設定
                set: { newDate in dueDate = newDate } // 選択した値をdueDateに反映
            ),
            displayedComponents: [isDatePicker ? .date : .hourAndMinute] // 日付または時間を選択可能
        )
        .datePickerStyle(.wheel) // ホイールスタイルのDatePickerを使用
        .padding() // 内側の余白を追加
        .background(Color(.secondarySystemBackground)) // 背景色を設定
        .cornerRadius(15) // 角丸を追加
    }
}
