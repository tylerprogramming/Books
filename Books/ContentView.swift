//
//  ContentView.swift
//  Books
//
//  Created by Tyler Reed on 10/13/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var dbContext
    
    @State private var editMode = EditMode.inactive

    @FetchRequest(sortDescriptors: [], predicate: nil, animation: .default)
    private var listOfBooks: FetchedResults<Books>

    var body: some View {
        NavigationView {
            List {
                ForEach(listOfBooks) { book in
                    HStack {
                        RowBook(book: book)
                        
                        if !editMode.isEditing {
                            NavigationLink(destination: DescriptionView(book: book), label: {
                                Text("")
                            })
                        } else {
                            NavigationLink(destination: EditBookView(book: book), label: {
                                Text("")
                            })
                        }
                    }
                }
                .onDelete(perform: { indexes in
                    Task(priority: .high) {
                        await deleteBook(indexes: indexes)
                    }
                })
            }
            .navigationTitle("Books")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: InsertBookView(), label: {
                        Image(systemName: "plus")
                    })
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .environment(\.editMode, $editMode)
        }
    }

    func deleteBook(indexes: IndexSet) async {
        withAnimation {
            for index in indexes {
                dbContext.delete(listOfBooks[index])
            }
            
            do {
                try dbContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct RowBook: View {
    let book: Books

    var body: some View {
        HStack(alignment: .top) {
            Image(uiImage: book.showThumbnail)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 100)
                .cornerRadius(10)
            VStack(alignment: .leading, spacing: 2) {
                Text(book.showTitle)
                    .bold()
                Text(book.showAuthor)
                Text(book.showYear)
                    .font(.caption)
                Spacer()
            }
            .padding(.top, 5)
            Spacer()
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
