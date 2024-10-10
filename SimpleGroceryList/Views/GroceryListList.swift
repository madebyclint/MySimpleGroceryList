//
//  GroceryListList.swift
//  SimpleGroceryList
//
//  Created by Clint Bush on 10/5/24.
//

import SwiftUI
import SwiftData

struct GroceryListList: View {
    @Query private var groceryLists: [GroceryList]
    @Environment(\.modelContext) private var context
    @State private var newGroceryList: GroceryList?
    
    init(titleFilter: String = "") {
        let predicate = #Predicate<GroceryList> { groceryList in
            titleFilter.isEmpty || groceryList.title.localizedStandardContains(titleFilter)
        }
        
        _groceryLists = Query(filter: predicate, sort: \GroceryList.title)
    }
    
    var body: some View {
        Group {
            if !groceryLists.isEmpty {
                List {
                    ForEach(groceryLists) { groceryList in
                        NavigationLink(groceryList.title) {
                            GroceryListDetail(groceryList: groceryList)
                        }
                    }
                    .onDelete(perform: deleteGroceryLists(indexes:))
                }
            } else {
                ContentUnavailableView {
                    Image(systemName: "list.bullet.rectangle.fill")
                        .resizable()
                        .padding(20)
                        .frame(width: 100, height: 100)
                        .background(Color.white)
                        .foregroundStyle(Color.teal)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(.teal, lineWidth: 5)
                        )
                    Text("Add grocery list")
                        .padding(.top)
                }
            }
        }
        .navigationTitle("Grocery Lists")
        .toolbar {
            ToolbarItem {
                Button("Add grocery list", systemImage: "plus", action: addGroceryList)
            }
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
        }
        .sheet(item: $newGroceryList) { groceryList in
            NavigationStack {
                GroceryListDetail(groceryList: groceryList, isNew: true)
            }
            .interactiveDismissDisabled()
        }
    }
    
    private func addGroceryList() {
        let newGroceryList = GroceryList(title: "")
        context.insert(newGroceryList)
        self.newGroceryList = newGroceryList
    }
    
    private func deleteGroceryLists(indexes: IndexSet) {
        for index in indexes {
            context.delete(groceryLists[index])
        }
    }
}

#Preview {
    NavigationStack {
        GroceryListList()
            .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("Filtered") {
    NavigationStack {
        GroceryListList(titleFilter: "wee")
            .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("Empty List") {
    NavigationStack {
        GroceryListList()
            .modelContainer(for: GroceryList.self, inMemory: true)
    }
}
