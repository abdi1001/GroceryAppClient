//
//  GroceryCategoryListScreen.swift
//  GroceryApp
//
//  Created by abdifatah ahmed on 10/27/24.
//

import SwiftUI

struct GroceryCategoryListScreen: View {
    
    @EnvironmentObject private var model: GroceryModel
    
    @State private var isPresented: Bool = false
    
    private func fetchGroceryCategories() async {
        do {
            try await model.populateGroceryCategories()
        }catch {
            print("Error fetching grocery categories: \(error)")
        }
    }
    
    private func deleteGroceryCategory(at offsets: IndexSet) {
        offsets.forEach { index in
            let groceryCategories = model.groceryCategories[index]
            Task {
                do {
                    try await model.deleteGroceryCategory(groceryCategories.id)
                }catch {
                    print("Error deleting grocery category: \(error)")
                }
            }
            
        }
    }
    
    var body: some View {
        
        ZStack {
            if model.groceryCategories.isEmpty {
                Text("No grocery categories found.")
            } else {
                List {
                    ForEach(model.groceryCategories) { groceryCategory in
                        NavigationLink(value: Route.groceryCategoryDetail(groceryCategory)) {
                            HStack {
                                Circle()
                                    .fill(.blue)
                                    .frame(width: 25, height: 25)
                                Text(groceryCategory.title)
                            }
                        }

                    }.onDelete(perform: deleteGroceryCategory)
                }
            }
        }
        .task {
            await fetchGroceryCategories()
        }.navigationTitle("Grocery Categories")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Logout") {
                        
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                }
                
            }.sheet(isPresented: $isPresented) {
                NavigationStack {
                    AddGroceryCategoryScreen()
                }
                
            }
    }
}

struct GroceryCategoryListScreenContainer: View {
    @StateObject private var model = GroceryModel()
    @StateObject private var appState = AppState()
    
    var body: some View {
        NavigationStack(path: $appState.routes) {
            GroceryCategoryListScreen()
                .navigationDestination(for: Route.self) { route in
                switch route {
                case .register:
                    RegistrationScreen()
                case .login:
                    LoginScreen()
                case .groceryCategoryList:
                    Text("Grocery Category List")
                case .groceryCategoryDetail(let groceryCategory):
                    GroceryDetailScreen(groceryCategory: groceryCategory)
                }
            }
        }
        .environmentObject(model)
        .environmentObject(appState)
    }
}

#Preview {
    GroceryCategoryListScreenContainer()
}
