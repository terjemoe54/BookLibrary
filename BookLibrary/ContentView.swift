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
    @State private var isSheetingPresented = false
        
    enum SortOption {
        case forward, reverse
     }
    
    var body: some View {
        NavigationStack {
            VStack {
                if !sortedAuthors.isEmpty {
                    EmptyAuthorsView()
                } else {
                    Picker(
                        "Sort by",
                        selection: $sortOption) {
                            Text("Forward").tag(SortOption.forward)
                            Text("Reverse").tag(SortOption.reverse)
                    }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                    
                    
                    List {
                        ForEach(sortedAuthors) { author in
                            DisclosureGroup("\(author.name) - ^[\(author.books.count) books](inflect: true)") {
                                ForEach(author.books) { book in
                                    HStack {
                                        Text(book.title)
                                        Spacer()
                                        Button("📝") {
                                            simpleUpdateBook(book)
                                        }
                                    }
                                }
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    // delete author
                                    deleteAuthor(author)
                                } label:  {
                                    Label("Delete", systemImage: "trash")
                                }
                                
                                Button {
                                    // edit
                                } label:  {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .tint(.blue)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Authors & Books")
            .toolbar {
                Button("➕ Add") {
    //                selectedAuthor = Author(name: "")
                    selectedAuthor = Author(name: "TEST NAME")
                    isSheetingPresented = true
                }
            }
            .sheet(isPresented: $isSheetingPresented) {
                if let author = selectedAuthor {
                    EditAuthorView(author: author)
                }
            }
        }
    }
    
    func simpleUpdateBook(_ book: Book) {
        book.title += ["😎", "😤", "🥱"].randomElement() ?? "😎"
        try? modelContext.save()
    }
    
    func deleteAuthor(_ author: Author) {
        modelContext.delete(author)
        try? modelContext.save()
    }
 }


struct EditAuthorView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var author: Author
    @State private var newBookTitle = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Edit Author") {
                    ValidatedTextField(
                        prompt: "Author Name",
                        text: $author.name,
                        errorMsg: "Invalid Author Name"
                    )
                }
            
                if author.name.count >= 2 {
                    Section("Add Book") {
                     ValidatedTextField(
                          prompt: "Book Name",
                          text: $newBookTitle,
                          errorMsg: "Invalid Title"
                      )
                        
                        Button("Add Book") {
                            if newBookTitle.count >= 2 {
                                // Create a new book
                                let newBook = Book(
                                    title: newBookTitle,
                                    author: author.name
                                )
                                
                                    modelContext.insert(newBook)
                                    author.books.append(newBook)
                                
                                // Persist
                                try? modelContext.save()
                                
                                newBookTitle = ""
                            }
                        }
                        .disabled(newBookTitle.count < 2)
                        
                        if !author.books.isEmpty {
                            Section("Books") {
                                ForEach(author.books) { book in
                                    Text(book.title)
                                        .swipeActions {
                                            Button(
                                                role: .destructive) {
                                                    // delete book
                                                    deleteBook(book)
                                                } label: {
                                                    Label("Delete", systemImage: "trash")
                                                }
                                        }
                                }
                            }
                        }
                        
                    }
                }
                
            }
            .navigationTitle("Edit Author")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                        .disabled(author.books.isEmpty)
                }
            }
        }
    }
    
    private func deleteBook(_ book: Book) {
        modelContext.delete(book)
        try? modelContext.save()
    }
}


#Preview {
    ContentView()
        .modelContainer(for: [Author.self, Book.self])
}

