//
//  InfoRow.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/24.
//
import SwiftUI

/// Todo情報を表示する行（タイトルと内容）を提供するビュー
///
/// - Parameters:
///  - title: 行のタイトル
///  - content: 表示する内容（URLまたはテキスト）
///
/// - Note:
///  - 表示内容がURLの場合、リンクとして表示し、クリックで開くことができます
///  - URLでない場合は、テキストとして表示し、コピー機能を提供します
struct InfoRow: View {

    let title: String

    let content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {  // タイトルと内容を縦に配置
            // タイトルの表示
            Text(LocalizedStringKey(title))  // ローカライズ対応
                .font(.caption)
                .foregroundColor(.secondary)

            // 内容がURLの場合、リンクとして表示
            if let url = URL(string: content),
               UIApplication.shared.canOpenURL(url) {
                HStack {
                    Text(content)  // URLの表示
                        .font(.body)
                        .foregroundColor(.blue)  // 青色のリンク風
                        .underline()  // 下線を引く
                        .lineLimit(nil)  // 長いURLが途中で切れないようにする
                        .onTapGesture {
                            UIApplication.shared.open(url)  // URLを開く
                        }
                }
            } else {
                // URLでない場合、テキストとして表示し、コピー機能を提供
                Text(content)
                    .font(.body)
                    .contextMenu {  // 長押しで表示されるコンテキストメニュー
                        Button(action: {
                            UIPasteboard.general.string = content  // クリップボードにコピー
                        }, label: {
                            Text("Copy")  // コピーアクション
                            Image(systemName: "document.on.document")
                        })
                    }
            }
        }
    }
}
