//
//  SampleData.swift
//  FriendsFavoriteMovies
//
//  Created by Clint Bush on 10/5/24.
//

import Foundation
import SwiftData

@MainActor
class SampleData {
    static let shared = SampleData()
    
    let modelContainer: ModelContainer
    
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    var groceryList: GroceryList {
        GroceryList.sampleData.first!
    }
    
    var groceryItem: GroceryItem {
        GroceryItem.sampleData.first!
    }
    
    private init() {
        let schema = Schema([
            GroceryList.self,
            GroceryItem.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            insertSampleData()
            
            try context.save()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    private func insertSampleData() {
        for groceryList in GroceryList.sampleData {
            context.insert(groceryList)
        }
        
        for groceryItem in GroceryItem.sampleData {
            context.insert(groceryItem)
        }
        
        GroceryList.sampleData[0].items = [
            GroceryItem.sampleData[1],
            GroceryItem.sampleData[2],
            GroceryItem.sampleData[3]
        ]
        GroceryList.sampleData[1].items = [
            GroceryItem.sampleData[0],
            GroceryItem.sampleData[1]
        ]
        GroceryList.sampleData[2].items = [
            GroceryItem.sampleData[4]
        ]
        GroceryList.sampleData[3].items = [
            GroceryItem.sampleData[0],
            GroceryItem.sampleData[1],
            GroceryItem.sampleData[2],
            GroceryItem.sampleData[3],
            GroceryItem.sampleData[4],
            GroceryItem.sampleData[5]
        ]
    }
}
