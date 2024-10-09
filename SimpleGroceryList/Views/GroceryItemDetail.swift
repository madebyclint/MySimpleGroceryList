//
//  GroceryItemDetail.swift
//  SimpleGroceryList
//
//  Created by Clint Bush on 10/6/24.
//

import SwiftUI

struct GroceryItemDetail: View {
    @Bindable var groceryItem: GroceryItem
    let isNew: Bool
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    init(groceryItem: GroceryItem, isNew: Bool = false) {
        self.groceryItem = groceryItem
        self.isNew = isNew
    }
    
//    var sortedFriends: [Friend] {
//        movie.favoritedBy.sorted { first, second in
//            first.name < second.name
//        }
//    }
    
    var body: some View {
        Form {
            TextField("Grocery item", text: $groceryItem.title)
            
//            if !groceryItem.favoritedBy.isEmpty {
//                Section("Favorited by") {
//                    ForEach(sortedFriends) { friend in
//                        Text(friend.name)
//                    }
//                }
//            } else {
//                /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
//            }
        }
        .navigationTitle("Item")
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
                        context.delete(groceryItem)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        GroceryItemDetail(groceryItem: SampleData.shared.groceryItem)
    }
}

#Preview("New Grocery Item") {
    NavigationStack {
        GroceryItemDetail(groceryItem: SampleData.shared.groceryItem, isNew: true)
    }
}
