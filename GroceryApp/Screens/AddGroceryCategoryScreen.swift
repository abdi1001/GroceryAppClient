//
//  AddGroceryCategoryScreen.swift
//  GroceryApp
//
//  Created by abdifatah ahmed on 10/26/24.
//

import SwiftUI
import GroceryAppSharedDTO

struct AddGroceryCategoryScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var model: GroceryModel
    
    @State private var title: String = ""
    @State private var colorCode: String = "#2ecc71"
    
    private func saveGroceryCategory() async {
        
        let grocryCategoryRequestDTO = GroceryCategoryRequestDTO(title: title, colorCode: colorCode)
        
        do {
            try await model.saveGroceryCategory(grocryCategoryRequestDTO)
            dismiss()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    private var isFormValid: Bool {
        !title.isEmptyOrWhitespace
    }
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            ColorSelector(colorCode: $colorCode)
        }
        .navigationTitle("Add New Category")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    Task {
                        await saveGroceryCategory()
                    }
                }
                .disabled(!isFormValid)
            }
        }
        
    }
}

#Preview {
    NavigationStack {
        AddGroceryCategoryScreen()
            .environmentObject(GroceryModel())
    }

}
