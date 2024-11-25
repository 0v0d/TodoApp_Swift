//
//  EmptyStateView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/15.
//
import SwiftUI

struct EmptyStateView: View {
    let title: String
    let systemImageName: String
    let description: String

    var body: some View {
        VStack {
            Image(systemName: systemImageName)
                .font(.largeTitle)
                .foregroundColor(.gray)
            Text(LocalizedStringKey(title))
                .font(.title)
                .padding(.top, 5)
            Text(LocalizedStringKey(description))
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}
