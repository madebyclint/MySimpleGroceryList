//
//  GroceryList.swift
//  SimpleGroceryList
//
//  Created by Clint Bush on 10/5/24.
//

import Foundation
import SwiftData

@Model
class GroceryList {
    var title: String
    var items: [GroceryItem]?
    
    init(title: String) {
        self.title = title
    }
    
    static let sampleData = [
        GroceryItem(title: "Weekly Groceries")
    ]
}
