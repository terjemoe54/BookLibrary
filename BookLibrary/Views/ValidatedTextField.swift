//
//  ValidatedTextField.swift
//  BookLibrary
//
//  Created by Terje Moe on 29/03/2025.
//


import SwiftUI

struct ValidatedTextField: View {
    let prompt: String
    @Binding var text: String
    let errorMsg: String
    
    var body: some View {
        VStack(alignment: .trailing) {
            TextField(prompt, text: $text)
            if text.count < 2 {
                Text("\(errorMsg)")
                    .font(.caption)
                    .foregroundStyle(.red)
                    .bold()
            }
        }
    }
}

#Preview {
    ValidatedTextField(
        prompt: "TEnter Author",
        text: .constant(""),
        errorMsg: "Invalid Author"
    )
    .padding()
}
