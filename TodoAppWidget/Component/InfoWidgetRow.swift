//
//  TodoAppWidgetContent.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/27.
//
import SwiftUI

/// ウィジェット内で情報を表示するための行コンポーネント
///
/// アイコンと2行のテキスト（タイトルと内容）を水平に配置した再利用可能なビューです。
///
/// ### 概要
/// - アイコン（SF Symbols）と2つのテキスト（タイトルと内容）を `HStack` で横並びに配置します。
/// - タイトルは小見出しスタイル、内容は本文スタイルで表示します。
///
/// ### IconNameの指定について
/// 以下のSF Symbolsアイコン名を利用するのが推奨されます：
/// - タイトル: `doc.text`
/// - コメント: `text.bubble`
/// - URL: `link`
/// - ステータス: `checkmark.circle.fill`
/// - 期日: `calendar.badge.clock`
/// - 作成日時: `calendar`
///
/// ### 使用例
/// ```swift
/// InfoWidgetRow(
///     title: "Task Title",
///     content: "This is a sample comment",
///     iconName: "doc.text"
/// )
/// ```
///
/// - Parameters:
///   - title: 行のタイトル。`LocalizedStringKey` として使用されます。
///   - content: 表示する主要なテキストコンテンツ。
///   - iconName: SF Symbols のアイコン名。システムで定義された名前を指定してください。
///
struct InfoWidgetRow: View {
    /// 行のタイトル
    /// - Note: LocalizedStringKey として使用されます。
    let title: String
    
    /// 表示する主要なコンテンツテキスト
    let content: String
    
    /// SF Symbols のアイコン名
    /// - Note: システムで定義されているアイコン名を指定してください。
    let iconName: String

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: iconName)
                .font(.title2)
                .foregroundColor(.accentColor)

            VStack(alignment: .leading, spacing: 4) {
                Text(LocalizedStringKey(title))
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)

                Text(content)
                    .font(.body)
                    .foregroundColor(.primary)
            }
        }
        .padding(.vertical, 8)
    }
}
