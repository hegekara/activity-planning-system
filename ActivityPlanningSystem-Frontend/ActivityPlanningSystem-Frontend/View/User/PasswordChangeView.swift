//
//  PasswordChangeView.swift
//  ActivityPlanningSystem-Frontend
//
//  Created by Ege Kara on 25.02.2025.
//

import SwiftUI

struct PasswordChangeView: View {
    
    @State var oldPassword : String = ""
    @State var newPassword : String = ""
    @State var newPasswordCheck : String = ""
    @State var errorMessage : String?
    
    var isPasswordMatch: Bool { newPassword == newPasswordCheck }
    
    func passwordChangeProccess() {
        errorMessage = nil
        
        guard !oldPassword.isEmpty, !newPassword.isEmpty, !newPasswordCheck.isEmpty else {
            errorMessage = "PLEASE_FILL_ALL_FIELDS"
            return
        }
        
        if isPasswordMatch {
            guard let id = getFromKeychain(key: "id") else {
                errorMessage = "USER_ID_NOT_FOUND"
                return
            }
            
            print("id: \(id)")
            
            changePassword(id: id, oldPassword: oldPassword, newPassword: newPassword) { error in
                
                DispatchQueue.main.async {
                    if let error = error {
                        self.errorMessage = "PASSWORD_CHANGE_FAILED: \(error)"
                    }else {return}
                }
                
            }
        } else {
            errorMessage = "REGISTER_PASSWORD_DO_NOT_MATCH"
        }
    }
    
    var body: some View {
        VStack{
            Form{
                Section{
                    SecureField("PASSWORD_CHANGE_OLD_PASSWORD", text: $oldPassword)
                    SecureField("PASSWORD_CHANGE_NEW_PASSWORD", text: $newPassword)
                    SecureField("PASSWORD_CHANGE_NEW_PASSWORD_CHECK", text: $newPasswordCheck)
                }
                Section{
                    Button(action: passwordChangeProccess) {
                        Text("PASSWORD_CHANGE_SUBMIT_BUTTON")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
        }
        .navigationTitle("PASSWORD_CHANGE_SCREEN")
    }
}

#Preview {
    PasswordChangeView()
}
