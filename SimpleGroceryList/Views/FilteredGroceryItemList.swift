//
//  FilteredGroceryItemList.swift
//  SimpleGroceryList
//
//  Created by Clint Bush on 10/8/24.
//

import SwiftUI

struct FilteredGroceryItemList: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationSplitView {
            GroceryItemList(titleFilter: searchText)
                .searchable(text: $searchText)
        } detail: {
            Text("Select an item")
                .navigationTitle("Item")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FilteredGroceryItemList()
        .modelContainer(SampleData.shared.modelContainer)
}
