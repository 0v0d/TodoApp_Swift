//
//  URLValidator.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/14.
//
import SwiftUI

/// URLのバリデーションを行う構造体
struct URLValidator {

    /// URLが有効かどうかを返すメソッド
    ///
    /// - Parameter urlString: バリデーションするURL文字列
    /// - Returns: URLが有効であれば`true`、無効であれば`false`
    ///
    /// 有効なURLの条件:
    /// - 空でない文字列であること
    /// - URLとして解釈できること
    /// - `http` または `https` スキームを持つこと
    /// - ホスト部分が存在すること
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
