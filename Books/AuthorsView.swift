//
//  AuthorsView.swift
//  Books
//
//  Created by Tyler Reed on 10/13/22.
//

import SwiftUI

struct AuthorsView: View {
    @FetchRequest(sortDescriptors: [], predicate: nil, animation: .default)
    private var listOfAuthors: FetchedResults<Authors>
    
    @Environment(\.dismiss) var dismiss
    @Binding var selected: Authors?
    
    var body: some View {
        List {
            ForEach(listOfAuthors) { author in
                HStack {
                    Text(author.showName)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    selected = author
                    dismiss()
                }
            }
        }
        .navigationTitle("Authors")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: InsertAuthorView(), label: {
                    Image(systemName: "plus")
                })
            }
        }
    }
}

struct AuthorsView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorsView(selected: .constant(nil))
    }
}
