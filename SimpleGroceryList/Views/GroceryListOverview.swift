//
//  GroceryListOverview.swift
//  SimpleGroceryList
//
//  Created by Clint Bush on 10/6/24.
//

import SwiftUI
import SwiftData

struct GroceryListOverview: View {
    @Bindable var groceryList: GroceryList
    let isNew: Bool
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var showItemList = false
    
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
    
    private func addItemToList() {
        showItemList = true
    }
    
    var body: some View {
        Form {
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
        .navigationTitle(groceryList.title)
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
            } else {
                ToolbarItem {
                    Button("Add grocery list", systemImage: "plus", action: addItemToList)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
        }
        .sheet(isPresented: $showItemList) {
            NavigationStack {
                GroceryItemSelectionList(groceryItems: groceryItems)
            }
            .interactiveDismissDisabled()
        }
    }
}

#Preview {
    NavigationStack {
        GroceryListOverview(groceryList: SampleData.shared.groceryList)
    }
    .modelContainer(SampleData.shared.modelContainer)
}

#Preview("New Grocery Item") {
    NavigationStack {
        GroceryListOverview(groceryList: SampleData.shared.groceryList, isNew: true)
    }
    .modelContainer(SampleData.shared.modelContainer)
}
