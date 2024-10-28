//
//  UserDefaults+Extensions.swift
//  GroceryApp
//
//  Created by abdifatah ahmed on 10/27/24.
//

import Foundation

extension UserDefaults {
    
    var userId: UUID? {
        get {
            guard let userIdAsString = string(forKey: "userId") else { return nil }
            
            return UUID(uuidString: userIdAsString)
            
        }
        
        set {
            set(newValue?.uuidString, forKey: "userId")
        }
    }
}
