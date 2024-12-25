//
//  URLValidator.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/14.
//
import SwiftUI

/// URLのバリデーションを行う構造体
///
/// 指定されたURL文字列が有効かどうかを判定するためのメソッドを提供します
///
/// - 提供メソッド:
/// - `isValid(_ urlString: String)`: 指定されたURL文字列が有効かどうかを判定します
///
/// - Note:
///  - 有効なURLの条件:
///   - 空でない文字列であること
///   - URLとして解釈可能であること
///   - スキームが `http` または `https` のいずれかであること
///   - ホスト部分が存在すること
struct URLValidator {

    /// 指定されたURL文字列が有効かどうかを判定するメソッド
    ///
    /// - Parameter urlString: バリデーション対象のURL文字列
    /// - Returns: URLが有効であれば `true`、無効であれば `false`
    func isValid(_ urlString: String) -> Bool {
        // URL文字列が空でなく、URLとして解釈可能かどうかを確認
        guard !urlString.isEmpty,
              let url = URL(string: urlString),
              let scheme = url.scheme,
              // http, httpsのみ許可
              ["http", "https"].contains(scheme),
              url.host != nil else {
            return false // いずれかの条件が満たされない場合は無効
        }
        return true // すべての条件を満たせば有効
    }
}
