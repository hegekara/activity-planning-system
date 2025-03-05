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
                ActivityListView(activities: fetcher.data)
            }
            Tab("HOME_SETTING_BUTTON", systemImage: "gear"){
                SettingsView()
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
