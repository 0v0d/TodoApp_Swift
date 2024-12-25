//
//  TodoAppWidgetContent.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/27.
//
import SwiftUI

/// ウィジェット内で情報を表示するための行コンポーネント
///
/// - アイコン（SF Symbols）と2つのテキスト（タイトルと内容）を `HStack` で横並びに配置します
/// - タイトルは小見出しスタイル、内容は本文スタイルで表示します
///
/// - Parameters:
///   - title: 行のタイトル`LocalizedStringKey` として使用されます
///   - content: 表示する主要なテキストコンテンツ
///   - iconName: SF Symbols のアイコン名システムで定義された名前を指定してください
///
/// - Note:
/// `IconName`の指定については、以下の例を参照してください
/// - タイトル: `doc.text`
/// - コメント: `text.bubble`
/// - URL: `link`
/// - ステータス: `checkmark.circle.fill`
/// - 期日: `calendar.badge.clock`
/// - 作成日時: `calendar`
struct InfoWidgetRow: View {

    let title: String

    let content: String

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
