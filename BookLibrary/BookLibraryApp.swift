//
//  BookLibraryApp.swift
//  BookLibrary
//
//  Created by Terje Moe on 27/03/2025.
//

import SwiftUI
import SwiftData

@main
struct BookLibraryApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Author.self, Book.self])
        }
    }
}
