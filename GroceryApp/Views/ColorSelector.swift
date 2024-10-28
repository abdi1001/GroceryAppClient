//
//  ColorSelector.swift
//  GroceryApp
//
//  Created by abdifatah ahmed on 10/26/24.
//

import SwiftUI

enum Color: String, CaseIterable {
    case green = "#2ecc71"
    case red = "#e74c3c"
    case blue = "#673ab7"
    case purple = "#9b59b6"
    case yellow = "#f1c40f"
    }

struct ColorSelector: View {
    
    @Binding var colorCode: String
    var body: some View {
        HStack{
            ForEach(Color.allCases, id: \.rawValue) { color in
                VStack {
                    Image(systemName: colorCode == color.rawValue ?
                          "record.circle.fill" : "circle.fill")
                    .font(.title)
                    //.foregroundColor(Color.fromHex(color.rawValue))
                    .clipShape(Circle())
                    .onTapGesture {
                        colorCode = color.rawValue
                    }
              }
            }
        }
    }

}

#Preview {
    ColorSelector(colorCode: .constant("#2ecc71"))
}
