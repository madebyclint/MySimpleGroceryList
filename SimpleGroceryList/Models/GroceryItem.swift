//
//  GroceryItem.swift
//  SimpleGroceryList
//
//  Created by Clint Bush on 10/5/24.
//

import Foundation
import SwiftData

@Model
class GroceryItem {
    var title: String
    var inList: [GroceryList]?
    
    init(title: String) {
        self.title = title
    }
    
    static let sampleData = [
        GroceryItem(title: "Carrots"),
        GroceryItem(title: "Ramen"),
        GroceryItem(title: "Almond milk"),
        GroceryItem(title: "Eggs"),
        GroceryItem(title: "Bread"),
        GroceryItem(title: "Bananas")
    ]
}
