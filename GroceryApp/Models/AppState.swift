//
//  AppState.swift
//  GroceryApp
//
//  Created by abdifatah ahmed on 10/26/24.
//

import Foundation
import GroceryAppSharedDTO

enum GroceryError: Error {
    case invalidResponse
    case invalidData
    case invalidURL
    case invalidHTTPStatus
    case loginFailed
}

enum Route: Hashable {
    case login
    case register
    case groceryCategoryList
    case groceryCategoryDetail(GroceryCategoryResponseDTO)
}

class AppState: ObservableObject {
    @Published var routes: [Route] = []
    @Published var errorWrapper: ErrorWrapper?
}
