//
//  GroceryCategoryResponseDTO+Extensions.swift
//  GroceryApp
//
//  Created by abdifatah ahmed on 10/27/24.
//

import Foundation
import GroceryAppSharedDTO

extension GroceryCategoryResponseDTO: Identifiable, Hashable {

    
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: GroceryCategoryResponseDTO, rhs: GroceryCategoryResponseDTO) -> Bool {
        lhs.id == rhs.id
    }
}
