//
//  ProfileView.swift
//  ActivityPlanningSystem-Frontend
//
//  Created by Ege Kara on 19.02.2025.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var userActivities: [Activity] = []
    @State private var isLoggedOut = false
    
    func logout() {
        clearKeychain()
        isLoggedOut = true
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        NavigationLink("SETTINGS_MYACTIVITIES_BUTTON", destination: ActivityListView(activities: userActivities))
                        NavigationLink("SETTINGS_CHANGE_PASSWORD_BUTTON", destination: PasswordChangeView())
                    }
                }
                .navigationTitle("SETTINGS_SCREEN_TITLE")
                .onAppear(perform: fetchActivities)
                
                Spacer()
                
                Button(action: logout) {
                    Text("SETTINGS_LOGOUT_BUTTON")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .fullScreenCover(isPresented: $isLoggedOut, content: { LoginView() })
        .navigationBarBackButtonHidden(true)
    }
    
    private func fetchActivities() {
        getUserActivities { response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error while fetching activities: \(error)")
                } else {
                    userActivities = response ?? []
                    if userActivities.isEmpty {
                        print("Activity list is empty")
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
