//
//  ContentView.swift
//  Books
//
//  Created by Tyler Reed on 10/13/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [], predicate: nil, animation: .default)
    private var listOfBooks: FetchedResults<Books>

    var body: some View {
        NavigationView {
            List {
                ForEach(listOfBooks) { book in
                    RowBook(book: book)
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Books")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
                    NavigationLink(destination: InsertBookView(), label: {
                        Image(systemName: "plus")
                    })
                }
            }
            Text("Select an item")
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { listOfBooks[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct RowBook: View {
    let book: Books
    
    var imageCover: UIImage {
        if let data = book.thumbnail, let image = UIImage(data: data) {
            return image
        } else {
            return UIImage(named: "nopicture")!
        }
    }
    
    var body: some View {
        HStack(alignment: .top) {
            Image(uiImage: imageCover)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 100)
                .cornerRadius(10)
            VStack(alignment: .leading, spacing: 2) {
                Text(book.title ?? " Undefined")
                    .bold()
                Text(book.author?.name ?? "Undefined")
                    .foregroundColor(book.author?.name != nil ? .black : .gray)
                Text(String(book.year))
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
