//
//  RegisterView.swift
//  ActivityPlanningSystem-Frontend
//
//  Created by Ege Kara on 13.02.2025.
//

import SwiftUI

struct RegisterView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var password2: String = ""
    @State private var errorMessage: String?
    @State private var isAuth = false
    
    var isPasswordMatch: Bool { password == password2 }
    
    func registerProccess() {
        errorMessage = nil
        
        guard !username.isEmpty, !password.isEmpty, !password2.isEmpty else {
            errorMessage = "PLEASE_FILL_ALL_FIELDS"
            return
        }
        
        if isPasswordMatch {
            register(username: username, password: password) { response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        errorMessage = "Register failed: \(error.localizedDescription)"
                        return
                    }
                    
                    if let response = response {
                        print(response)
                        UserDefaults.standard.set(response.token, forKey: "token")
                        UserDefaults.standard.set(response.id, forKey: "id")
                        
                        isAuth = true
                    }
                }
            }
        } else {
            errorMessage = "REGISTER_PASSWORD_DO_NOT_MATCH"
        }
    }

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack {
                Text("Register")
                    .font(.largeTitle)
                
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding(.top, 30)
                
                Form {
                    VStack {
                        TextField("AUTH_USERNAME", text: $username)
                            .padding(.horizontal)
                            .onChange(of: username) { errorMessage = nil }
                    }
                    .ignoresSafeArea(.keyboard)
                    
                    VStack {
                        SecureField("AUTH_PASSWORD", text: $password)
                            .padding(.horizontal)
                            .onChange(of: password) { errorMessage = nil }
                    }
                    .ignoresSafeArea(.keyboard)
                    
                    VStack {
                        SecureField("AUTH_PASSWORD_DOUBLE", text: $password2)
                            .padding(.horizontal)
                            .onChange(of: password2) { errorMessage = nil }
                    }
                    .ignoresSafeArea(.keyboard)
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                            .padding(4)
                    }
                    
                    Section {
                        Button(action: registerProccess) {
                            Text("AUTH_REGISTER_BUTTON")
                                .frame(maxWidth: .infinity)
                                .padding(5)
                                .cornerRadius(8)
                        }
                    }
                }
            }
            .padding(.vertical, 50)
        }
    }
}

#Preview {
    RegisterView()
}
