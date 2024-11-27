//
//  EmptyWidgetView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/27.
//
import SwiftUI

struct EmptyWidgetView: View {
    var body: some View {
        Text(LocalizedStringKey("NoTasks"))
            .font(.system(size: 14))
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, alignment: .center)
    }
}
