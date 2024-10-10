//
//  GroceryItemSelectionList.swift
//  SimpleGroceryList
//
//  Created by Clint Bush on 10/9/24.
//

import SwiftUI

struct GroceryItemSelectionList: View {
    let groceryItems: [GroceryItem]
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var body: some View {
        List {
            ForEach(groceryItems) { item in
                Button(item.title) {
//                    context.delete(groceryList)
                    dismiss()
                }
            }
        }
        .navigationTitle("Add item")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
//            ToolbarItem(placement: .confirmationAction) {
//                Button("Save") {
//                    dismiss()
//                }
//            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
//                    context.delete(groceryList)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    GroceryItemSelectionList(groceryItems: [SampleData.shared.groceryItem])
}
