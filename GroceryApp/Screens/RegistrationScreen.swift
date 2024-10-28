//
//  RegistrationScreen.swift
//  GroceryApp
//
//  Created by abdifatah ahmed on 10/26/24.
//

import SwiftUI

struct RegistrationScreen: View {
    
    @EnvironmentObject private var model: GroceryModel
    @EnvironmentObject private var appState: AppState
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    
    //private let httpClient = HTTPClient()
    
    private var isFormValid: Bool {
        !username.isEmptyOrWhitespace && !password.isEmptyOrWhitespace
        && (password.count >= 8 && password.count <= 16)
    }
    
    private func register() async {
        do {
            let registerResponseDTO =  try await model.register(username: username, password: password)
            
            if !registerResponseDTO.error {
                appState.routes.append(.login)
            } else {
                errorMessage = registerResponseDTO.reason ?? "Unknown Error"
            }
            print(registerResponseDTO)
        } catch {
            errorMessage = error.localizedDescription
        }
        
    }
    
    var body: some View {
        Form {
            TextField("Username", text: $username)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
            HStack {
                Button("Register") {
                    Task {
                        await register()
                    }
                    
                }.buttonStyle(.borderless)
                    .disabled(!isFormValid)
                Spacer()
                Button("Login") {
                    appState.routes.append(.login)
                }.buttonStyle(.borderless)
            }
            Text(errorMessage)
            
        }
        .navigationTitle("Registration")
    }
}

struct RegistrationScreenContainaer: View {
    @StateObject private var model = GroceryModel()
    @StateObject private var appState = AppState()
    
    var body: some View {
        NavigationStack(path: $appState.routes) {
            RegistrationScreen()
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

struct RegistrationScreen_Peviews: PreviewProvider {
    static var previews: some View {
        RegistrationScreenContainaer()
    }
}
