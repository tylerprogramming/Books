//
//  Book.swift
//  Books
//
//  Created by Tyler Reed on 10/13/22.
//

import SwiftUI
import CoreData

struct Book: Codable {
    var title: String
    var author: String
    var year: Int
    var cover: String?
}

struct BookViewModel: Identifiable {
    let id: UUID = UUID()
    var book: Book
    
    var title: String {
        return book.title.capitalized
    }
    
    var author: String {
        return book.author.capitalized
    }
    
    var year: String {
        return String(book.year)
    }
    
    var cover: UIImage {
        return UIImage(named: "nopicture")!
    }
}

class ApplicationData: ObservableObject {
    @Published var book: BookViewModel
    
    
    init() {
        book = BookViewModel(book: Book(title: "test", author: "Me", year: 1988))
    }
}
