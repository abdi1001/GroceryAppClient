//
//  GroceryItemListView.swift
//  GroceryApp
//
//  Created by abdifatah ahmed on 10/28/24.
//

import SwiftUI
import GroceryAppSharedDTO

struct GroceryItemListView: View {
    
    let groceryItems: [GroceryItemResponseDTO]
    
    var body: some View {
        List {
            ForEach(groceryItems) { groceryItem in
                Text(groceryItem.title)
            }
        }
    }
}

#Preview {
    GroceryItemListView(groceryItems: [])
}
