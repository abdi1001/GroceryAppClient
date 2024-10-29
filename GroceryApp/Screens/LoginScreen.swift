//
//  LoginScreen.swift
//  GroceryApp
//
//  Created by abdifatah ahmed on 10/26/24.
//

import SwiftUI

struct LoginScreen: View {
    
    @EnvironmentObject private var model: GroceryModel
    @EnvironmentObject private var AppState: AppState
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    
    private var isFormValid: Bool {
        !username.isEmptyOrWhitespace && !password.isEmptyOrWhitespace
        && (password.count >= 8 && password.count <= 16)
    }
    
    private func login() async {
        do {
            let loginResponseDTO = try await model.login(username: username, password: password)
            if loginResponseDTO.error {
                errorMessage = loginResponseDTO.reason ?? "Unknown Error"
                AppState.errorWrapper = ErrorWrapper(error: GroceryError.loginFailed, guidance: loginResponseDTO.reason ?? "Unknown Error")
            } else {
                // toke the user to grocery categories screen lsit
                AppState.routes.append(.groceryCategoryList)
            }
            print(loginResponseDTO)
        }catch {
            errorMessage = error.localizedDescription
            AppState.errorWrapper = ErrorWrapper(error: error, guidance: error.localizedDescription)
        }
 
    }
    
    var body: some View {
        Form {
            TextField("Username", text: $username)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
            HStack {
                Button("Login") {
                    Task {
                        await login()
                    }
                }.buttonStyle(.borderless)
                    .disabled(!isFormValid)
                Spacer()
                Button("Register") {
                    AppState.routes.append(.register)
                }.buttonStyle(.borderless)
            }
            Text(errorMessage)
            
        }
        .navigationTitle("Login")
        .navigationBarBackButtonHidden(true)
        .sheet(item: $AppState.errorWrapper) { errorWrapper in
            ErrorView(errorWrapper: errorWrapper)
                .presentationDetents([.fraction(0.25)])
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            LoginScreen()
                .environmentObject(GroceryModel())
                .environmentObject(AppState())
        }
    }
}
