//
//  DueDatePickerSection.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/15.
//
import SwiftUI

/// 期日選択用のセクション
struct DueDatePickerSection: View {
    /// 期限日を管理するバインディング
    @Binding var dueDate: Date?
    /// 日付および時間のバリデーションを行うユーティリティ
    let dateValidator = DateValidator()

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            // 日付選択用の行を表示
            DueDatePickerRow(
                dueDate: $dueDate,
                title: "DueDate",             // 日付選択のタイトル
                errorMessage: "DueDateError", // 日付バリデーションエラーメッセージ
                pickerTitle: "SelectDate",    // 日付ピッカーのタイトル
                isDatePicker: true,           // 日付選択モードを指定
                isError: !dateValidator.isDueDateValid(dueDate) // 日付の妥当性チェック
            )

            // 時間選択用の行を表示
            DueDatePickerRow(
                dueDate: $dueDate,
                title: "Time",                // 時間選択のタイトル
                errorMessage: "TimeError",    // 時間バリデーションエラーメッセージ
                pickerTitle: "SelectTime",    // 時間ピッカーのタイトル
                isDatePicker: false,          // 時間選択モードを指定
                isError: !dateValidator.isTimeValid(dueDate) // 時間の妥当性チェック
            )
        }
    }
}

private struct DueDatePickerRow: View {
    /// 期限日を管理するバインディング
    @Binding var dueDate: Date?

    /// 行のタイトル（例: 日付または時間）
    let title: LocalizedStringKey

    /// エラーメッセージ（バリデーション失敗時に表示）
    let errorMessage: LocalizedStringKey

    /// DatePickerのタイトル（モーダルで表示されるラベル）
    let pickerTitle: LocalizedStringKey

    /// DatePickerが日付選択かどうかを指定
    var isDatePicker: Bool = true

    /// エラーが発生しているかどうか
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
