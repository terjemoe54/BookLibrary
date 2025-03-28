//
//  ContentView.swift
//  BookLibrary
//
//  Created by Terje Moe on 27/03/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Author.name, order: .forward)
    private var forwardOrderAuthors: [Author]
    
    @Query(sort: \Author.name, order: .reverse)
    private var reverseOrderAuthors: [Author]
    
    var sortedAuthors: [Author] {
        sortOption == .forward ? forwardOrderAuthors : reverseOrderAuthors
    }
    @State private var sortOption: SortOption = .forward
  
    @State private var selectedAuthor: Author?
    @State private var isEditingAuthor = false
    @State private var isSheetPresented = false
        
    enum SortOption {
        case forward, reverse
     }
    
    var body: some View {
        NavigationStack {
            VStack {
                if sortedAuthors.isEmpty {
                    EmptyAuthorsView()
                } else {
                    
                }
            }
            .navigationTitle("Authors & Books")
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(for: [Author.self, Book.self])
}
