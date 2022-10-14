//
//  InsertAuthorView.swift
//  Books
//
//  Created by Tyler Reed on 10/13/22.
//

import SwiftUI

struct InsertAuthorView: View {
    @Environment(\.managedObjectContext) var dbContext
    @Environment(\.dismiss) var dismiss
    
    @State private var inputName: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Name:")
                TextField("Insert Name:", text: $inputName)
                    .textFieldStyle(.roundedBorder)
            }
            HStack {
                Spacer()
                Button("Save") {
                    let newName = inputName.trimmingCharacters(in: .whitespaces)
                    
                    if !newName.isEmpty {
                        Task(priority: .high) {
                            await storeAuthor(name: newName)
                        }
                    }
                }
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Add Author")
    }
    
    func storeAuthor(name: String) async {
        await dbContext.perform {
            let newAuthor = Authors(context: dbContext)
            newAuthor.name = name
            
            do {
                try dbContext.save()
                dismiss()
            } catch {
                print("Error saving Author: \(name)")
            }
        }
    }
}
