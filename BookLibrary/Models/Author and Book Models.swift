//
//  Author and Book Models.swift
//  BookLibrary
//
//  Created by Terje Moe on 28/03/2025.
//

import Foundation
import SwiftData

@Model
class Book {
    var title: String
    var author: String?
    
    init(title: String, author: String? = nil) {
        self.title = title
        self.author = author
    }
}

@Model
class Author {
    var name: String
    
    @Relationship(deleteRule: .cascade)
    var books: [Book] = []
    
    init(name: String) {
        self.name = name
    }
}
