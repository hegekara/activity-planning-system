//
//  LoginView.swift
//  ActivityPlanningSystem-Frontend
//
//  Created by Ege Kara on 13.02.2025.
//

import SwiftUI

struct LoginView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    @State private var isAuth = false
    @State private var isRegisterPresented = false
    
    func loginProccess(){
        
        errorMessage = nil
        
        guard !username.isEmpty, !password.isEmpty else {
            errorMessage = "FILL_ALL_FIELDS"
            return
        }
        
        login(username: username, password: password) { response, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    errorMessage = "AUTH_LOGIN_FAILED \(error)"
                    return
                }
                
                if let response = response{
                    print(response)
                    
                    savePasswordKeychain(username: username, password: password)
                    saveTokenKeychain(token: response.token)
                    saveIdKeychain(id: response.id)
                    
                    isAuth = true
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack {
                Text("AUTH_LOGIN_TITLE")
                    .font(.largeTitle)
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding(.top, 30)
                
                Form {
                    VStack() {
                        TextField("AUTH_USERNAME", text: $username)
                            .padding(.horizontal)
                            .onChange(of: username) { errorMessage = nil }
                    }
                    .ignoresSafeArea(.keyboard)
                    
                    VStack{
                        SecureField("AUTH_PASSWORD", text: $password)
                            .padding(.horizontal)
                            .onChange(of: username) { errorMessage = nil }
                    }
                    .ignoresSafeArea(.keyboard)
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                            .padding(4)
                    }
                    
                    Section {
                        Button(action: {loginProccess()}) {
                            Text("AUTH_LOGIN_BUTTON")
                                .frame(maxWidth: .infinity)
                                .padding(5)
                                .cornerRadius(8)
                        }
                    }
                    
                    Button("AUTH_GOTO_REGISTER_BUTTON") {
                        isRegisterPresented = true
                    }
                    .frame(maxWidth: .infinity)
                    .padding(5)
                    .cornerRadius(8)
                }
            }
            .padding(.vertical, 50)
            .ignoresSafeArea(.keyboard)
        }
        .sheet(isPresented: $isRegisterPresented) {
            RegisterView()
        }
        .fullScreenCover(isPresented: $isAuth, content: {HomeView()})
    }
}

#Preview {
    LoginView()
}
