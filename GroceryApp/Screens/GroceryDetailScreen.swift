//
//  GroceryDetailScreen.swift
//  GroceryApp
//
//  Created by abdifatah ahmed on 10/27/24.
//

import SwiftUI
import GroceryAppSharedDTO

struct GroceryDetailScreen: View {
    
    let groceryCategory: GroceryCategoryResponseDTO
    @State private var isPresented: Bool = false
    @EnvironmentObject private var model: GroceryModel
    
    private func populateGroceryItems() async {
        do {
            try await model.populateGroceryItemsBy(groceryCategoryId: groceryCategory.id)
        }catch {
            
        }
       
    }
    
    private func deleteGroceryItem(groceryItemId: UUID) {
        Task {
            do {
                try await model.deleteGroceryItem(groceryCategoryId: groceryCategory.id, groceryItemId: groceryItemId)
            }catch {
                print(error.localizedDescription)
            }
            
        }
        
    }
    
    var body: some View {
        VStack {
            if model.groceryItems.isEmpty {
                Text("No Grocery Items Found")
            } else {
                GroceryItemListView(groceryItems: model.groceryItems, onDelete: deleteGroceryItem)
            }
        }.navigationTitle(groceryCategory.title)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Grocery Item") {
                        isPresented = true
                    }
                }
            }
            .sheet(isPresented: $isPresented) {
                NavigationStack {
                    AddGroceryItemScreen()
                }
                
            }
            .onAppear {
                model.groceryCategory = groceryCategory
            }
            .task {
                await populateGroceryItems()
            }
    }
}


#Preview {
    NavigationStack {
        GroceryDetailScreen(groceryCategory: GroceryCategoryResponseDTO(id: UUID(uuidString: "E698D063-9702-4360-9F6A-3BB824C9F5BF")!, title: "Fruits", colorCode: "#2ecc71"))
            .environmentObject(GroceryModel())
    }
}

