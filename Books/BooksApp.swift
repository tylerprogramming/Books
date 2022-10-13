//
//  BooksApp.swift
//  Books
//
//  Created by Tyler Reed on 10/13/22.
//

import SwiftUI

@main
struct BooksApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
