//
//  DateValidator.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/14.
//
import Foundation

/// 日付のバリデーションを行う構造体
///
/// 指定された日付が特定の条件を満たしているかを判定するためのメソッドを提供します
///
/// - 提供メソッド:
/// - `isTimeValid(_ date: Date?)`: 指定された時刻が現在時刻以降であるかを判定します
/// - `isDueDateValid(_ date: Date?)`: 指定された期限日が今日以降であるかを判定します
///
/// - Note:
/// - 日付が `nil` の場合は、バリデーションをスキップします
/// - 常に `true` のはユーザーが日付を指定しないケースに対応するためです
struct DateValidator {

    /// 指定された時刻が現在時刻以降であるかを判定します
    ///
    /// - Parameter date: バリデーション対象の日付（`Date?` 型）
    /// - Returns: 時刻が現在時刻以降であれば `true`、それ以前であれば `false`
    /// - Note: 日付が `nil` の場合は、制限がないものとして `true` を返します
    func isTimeValid(_ date: Date?) -> Bool {
        // 日付が `nil` の場合、`true` を返す（制限なし）
        guard let date = date else { return true }
        // 指定された日付が現在時刻以降かを確認
        return date >= Date()
    }

    /// 指定された期限日が今日以降の日付であるかを判定します
    ///
    /// - Parameter date: バリデーション対象の期限日（`Date?` 型）
    /// - Returns: 期限が今日以降であれば `true`、それ以前であれば `false`
    /// - Note: 時間部分は無視して日付だけを比較します
    ///         日付が `nil` の場合は、制限がないものとして `true` を返します
    func isDueDateValid(_ date: Date?) -> Bool {
        // 日付が `nil` の場合、`true` を返す（制限なし）
        guard let date = date else { return true }
        // 指定された日付が今日以降かを確認（時間部分は無視）
        return date >= Calendar.current.startOfDay(for: Date())
    }
}
