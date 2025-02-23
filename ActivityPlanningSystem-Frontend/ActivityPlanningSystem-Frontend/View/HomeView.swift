//
//  HomeView.swift
//  ActivityPlanningSystem-Frontend
//
//  Created by Ege Kara on 19.02.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var fetcher = ActivityFetcher()
    var body: some View {
        TabView{
            Tab("HOME_MAP_BUTTON", systemImage: "map"){
                MapView(fetcher: fetcher)
            }
            Tab("HOME_ACTIVITIES_BUTTON", systemImage: "figure"){
                ActivityListView()
            }
            Tab("HOME_PROFILE_BUTTON", systemImage: "person"){
                ProfileView()
            }
        }
        .onAppear(){
            fetcher.fetchActivities()
        }
    }
}

#Preview {
    HomeView()
}
