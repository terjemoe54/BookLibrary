//
//  EmptyAuthorsView.swift
//  BookLibrary
//
//  Created by Terje Moe on 28/03/2025.
//
import SwiftUI

struct EmptyAuthorsView: View {
    var body: some View {
        VStack {
            Image(systemName: "book.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundStyle(.blue)
            
            Text("No Authors Yet?")
                .font(.title)
                .bold()
                .foregroundStyle(.primary)
            
            Text("Please share your favorite books and authors with us!")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}
