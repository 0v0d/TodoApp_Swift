//
//  DatePickerComponent.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/17.
//

/// 日付選択コンポーネントの種類を表す列挙型
///
/// - Note: `DatePickerComponent`は、`DatePicker`で選択可能な日付の要素を表します
enum DatePickerComponent: Int {
    case month = 0
    case day
    case year
    case hour
    case minute
    case ampm
}
