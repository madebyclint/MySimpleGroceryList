//
//  FilteredGroceryListList.swift
//  SimpleGroceryList
//
//  Created by Clint Bush on 10/8/24.
//

import SwiftUI

struct FilteredGroceryListList: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationSplitView {
            GroceryListList(titleFilter: searchText)
                .searchable(text: $searchText)
        } detail: {
            Text("Select a list")
                .navigationTitle("List")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FilteredGroceryListList()
        .modelContainer(SampleData.shared.modelContainer)
}
