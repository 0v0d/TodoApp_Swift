//
//  EmptyWidgetView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/27.
//
import SwiftUI

struct EmptyWidgetView: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "tray.fill")
                .font(.system(size: 40))
                .foregroundColor(.secondary)

            Text(LocalizedStringKey("NoTasks"))
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
}
