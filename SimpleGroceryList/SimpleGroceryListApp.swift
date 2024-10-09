//
//  SimpleGroceryListApp.swift
//  SimpleGroceryList
//
//  Created by Clint Bush on 10/8/24.
//

import SwiftUI

@main
struct SimpleGroceryListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [GroceryItem.self])
    }
}
