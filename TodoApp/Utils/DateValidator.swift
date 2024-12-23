//
//  DateValidator.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/14.
//
import Foundation

/// 日付のバリデーションを行う構造体
struct DateValidator {

    /// 時刻が現在時刻以降であるかどうかを判定するメソッド
    ///
    /// - Parameter date: バリデーションする日付（`Date`型）
    /// - Returns: 時刻が現在時刻以降であれば`true`、それ以前であれば`false`
    ///
    /// 日付が`nil`の場合は常に`true`を返す。
    /// ユーザーが日付を指定しない場合にも保存できるようにするためです。
    func isTimeValid(_ date: Date?) -> Bool {
        // 日付が`nil`の場合、`true`を返す（制限なし）
        guard let date = date else { return true }
        // 指定された日付が現在時刻以降かを確認
        return date >= Date()
    }

    /// 期限が今日以降の日付であるかどうかを判定するメソッド
    ///
    /// - Parameter date: バリデーションする期限日（`Date`型）
    /// - Returns: 期限が今日以降であれば`true`、それ以前であれば`false`
    ///
    /// 日付が`nil`の場合は常に`true`を返します。
    /// ユーザーが日付を指定しない場合にも保存できるようにするためです。
    func isDueDateValid(_ date: Date?) -> Bool {
        // 日付が`nil`の場合、`true`を返す（制限なし）
        guard let date = date else { return true }
        // 指定された日付が今日以降かを確認（時間部分は無視）
        return date >= Calendar.current.startOfDay(for: Date())
    }
}
