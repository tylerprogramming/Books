//
//  InsertBookView.swift
//  Books
//
//  Created by Tyler Reed on 10/13/22.
//

import SwiftUI

struct InsertBookView: View {
    @Environment(\.managedObjectContext) var dbContext
    @Environment(\.dismiss) var dismiss
    @State private var inputTitle: String = ""
    @State private var inputYear: String = ""
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Title:")
                TextField("Insert Title", text: $inputTitle)
                    .textFieldStyle(.roundedBorder)
            }
            HStack {
                Text("Year:")
                TextField("Insert Year", text: $inputYear)
                    .textFieldStyle(.roundedBorder)
            }
            HStack {
                Text("Author:")
                Text("Undefined")
                    .foregroundColor(.gray)
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
        .padding()
        .navigationTitle("Add Book")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    let newTitle = inputTitle.trimmingCharacters(in: .whitespaces)
                    let newYear = Int32(inputYear)
                    
                    if !newTitle.isEmpty && newYear != nil {
                        Task(priority: .high) {
                            await storeBook(title: newTitle, year: newYear!)
                        }
                    }
                }
            }
        }
    }
    
    func storeBook(title: String, year: Int32) async {
        await dbContext.perform {
            let newBook = Books(context: dbContext)
            newBook.title = title
            newBook.year = year
            newBook.author = nil
            newBook.cover = UIImage(named: "bookcover")?.pngData()
            newBook.thumbnail = UIImage(named: "bookthumbnail")?.pngData()
            
            do {
                try dbContext.save()
                dismiss()
            } catch {
                print("Error saving record \(newBook)")
            }
        }
    }
}

