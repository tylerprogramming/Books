//
//  EditBookView.swift
//  Books
//
//  Created by Tyler Reed on 10/14/22.
//

import SwiftUI

struct DescriptionView: View {
    @State var book: Books
    
    var body: some View {
        Text("The book is \(book.showTitle)")
    }
}
