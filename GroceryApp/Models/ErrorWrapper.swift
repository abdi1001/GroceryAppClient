//
//  ErrorWrapper.swift
//  GroceryApp
//
//  Created by abdifatah ahmed on 10/28/24.
//

import Foundation

struct ErrorWrapper: Identifiable {
    let id: UUID = UUID()
    let error: Error
    let guidance: String
}
