//
//  ErrorLabel.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/15.
//
import SwiftUI

struct ErrorLabel: View {
    let message: LocalizedStringKey
    
    var body: some View {
        HStack {
            Text(message)
                .font(.callout)
                .foregroundColor(.red)
            Spacer()
        }
        .padding(.leading, 16)
    }
}
