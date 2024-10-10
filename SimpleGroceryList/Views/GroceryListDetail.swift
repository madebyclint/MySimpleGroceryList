//
//  GroceryListDetail.swift
//  SimpleGroceryList
//
//  Created by Clint Bush on 10/6/24.
//

import SwiftUI
import SwiftData

struct GroceryListDetail: View {
    @Bindable var groceryList: GroceryList
    let isNew: Bool
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @Query(sort: \GroceryItem.title) private var groceryItems: [GroceryItem]
    
    init(groceryList: GroceryList, isNew: Bool = false) {
        self.groceryList = groceryList
        self.isNew = isNew
    }
    
    var sortedItems: [GroceryItem] {
        groceryList.items.sorted { first, second in
            first.title < second.title
        }
    }
    
    private func addToList() {
        
    }
    
    var body: some View {
        Form {
            TextField("Grocery list", text: $groceryList.title)
            
            if !groceryList.items.isEmpty {
                Section("Items") {
                    ForEach(sortedItems) { item in
                        Text(item.title)
                    }
                }
            } else {
                /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
            }
        }
        .navigationTitle("List")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isNew {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        context.delete(groceryList)
                        dismiss()
                    }
                }
            }
        }
//        .sheet(item: groceryList) { groceryList in
//            Picker("Items", selection: $groceryList.items) {
//                ForEach(groceryItems) { item in
//                    Text(item.title)
//                        .tag(item)
//                }
//            }
//        }
    }
}

#Preview {
    NavigationStack {
        GroceryListDetail(groceryList: SampleData.shared.groceryList)
    }
    .modelContainer(SampleData.shared.modelContainer)
}

#Preview("New Grocery Item") {
    NavigationStack {
        GroceryListDetail(groceryList: SampleData.shared.groceryList, isNew: true)
    }
    .modelContainer(SampleData.shared.modelContainer)
}
