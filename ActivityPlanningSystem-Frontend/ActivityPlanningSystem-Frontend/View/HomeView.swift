//
//  HomeView.swift
//  ActivityPlanningSystem-Frontend
//
//  Created by Ege Kara on 19.02.2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView{
            Tab("HOME_MAP_BUTTON", systemImage: "map"){
                MapView()
            }
            Tab("HOME_ACTIVITIES_BUTTON", systemImage: "figure"){
                ActivityView()
            }
            Tab("HOME_PROFILE_BUTTON", systemImage: "person"){
                ProfileView()
            }
        }
    }
}

#Preview {
    HomeView()
}
