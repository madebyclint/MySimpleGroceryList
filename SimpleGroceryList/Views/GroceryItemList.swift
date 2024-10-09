//
//  GroceryItemList.swift
//  SimpleGroceryList
//
//  Created by Clint Bush on 10/5/24.
//

import SwiftUI
import SwiftData

struct GroceryItemList: View {
    @Query private var groceryItems: [GroceryItem]
    @Environment(\.modelContext) private var context
    @State private var newGroceryItem: GroceryItem?
    
    init(titleFilter: String = "") {
        let predicate = #Predicate<GroceryItem> { groceryItem in
            titleFilter.isEmpty || groceryItem.title.localizedStandardContains(titleFilter)
        }
        
        _groceryItems = Query(filter: predicate, sort: \GroceryItem.title)
    }
    
    var body: some View {
        Group {
            if !groceryItems.isEmpty {
                List {
                    ForEach(groceryItems) { groceryItem in
                        NavigationLink(groceryItem.title) {
                            GroceryItemDetail(groceryItem: groceryItem)
                        }
                    }
                    .onDelete(perform: deleteGroceryItems(indexes:))
                }
            } else {
                ContentUnavailableView {
                    Image(systemName: "carrot.fill")
                        .resizable()
                        .padding(20)
                        .frame(width: 100, height: 100)
                        .background(Color.white)
                        .foregroundStyle(Color.orange)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(.orange, lineWidth: 5)
                        )
                    Text("Add grocery item")
                        .padding(.top)
                }
            }
        }
        .navigationTitle("Grocery Items")
        .toolbar {
            ToolbarItem {
                Button("Add grocery item", systemImage: "plus", action: addGroceryItem)
            }
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
        }
        .sheet(item: $newGroceryItem) { groceryItem in
            NavigationStack {
                GroceryItemDetail(groceryItem: groceryItem, isNew: true)
            }
            .interactiveDismissDisabled()
        }
    }
    
    private func addGroceryItem() {
        let newGroceryItem = GroceryItem(title: "")
        context.insert(newGroceryItem)
        self.newGroceryItem = newGroceryItem
    }
    
    private func deleteGroceryItems(indexes: IndexSet) {
        for index in indexes {
            context.delete(groceryItems[index])
        }
    }
}

#Preview {
    NavigationStack {
        GroceryItemList()
            .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("Filtered") {
    NavigationStack {
        GroceryItemList(titleFilter: "b")
            .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("Empty List") {
    NavigationStack {
        GroceryItemList()
            .modelContainer(for: GroceryItem.self, inMemory: true)
    }
}
