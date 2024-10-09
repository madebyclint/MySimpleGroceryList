//
//  ContentView.swift
//  SimpleGroceryList
//
//  Created by Clint Bush on 10/8/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
//            Tab("Friends", systemImage: "person.and.person") {
//                FriendList()
//            }
            
            Tab("Movies", systemImage: "carrot.fill") {
                FilteredGroceryItemList()
            }
                
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(SampleData.shared.modelContainer)
}
