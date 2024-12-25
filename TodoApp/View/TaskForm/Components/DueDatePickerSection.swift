//
//  DueDatePickerSection.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/15.
//
import SwiftUI

/// 期限日を選択するためのDatePickerを表示
///
/// - Parameters:
/// -  `dueDate`: 期限日を管理するバインディング (`Date?` 型)
/// - `dateValidator`: 日付および時間のバリデーションを行うユーティリティ (`DateValidator` 型)
///
/// - Note:
///  - 期限日は、日付と時間の両方を選択できます
///  - バリデーションエラーが発生した場合にはエラーメッセージを表示します。
struct DueDatePickerSection: View {

    @Binding var dueDate: Date?

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
