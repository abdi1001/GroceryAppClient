//
//  StringExtensions.swift
//  GroceryApp
//
//  Created by abdifatah ahmed on 10/26/24.
//

import Foundation

extension String {
    var isEmptyOrWhitespace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
