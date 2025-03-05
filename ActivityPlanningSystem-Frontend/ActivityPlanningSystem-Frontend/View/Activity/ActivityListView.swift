//
//  ActivityListView.swift
//  ActivityPlanningSystem-Frontend
//
//  Created by Ege Kara on 19.02.2025.
//

import SwiftUI

struct ActivityListView: View {
    
    @State var activities: [Activity]
    @State private var category: String = ""
    @State private var categoryList: [String] = []
    
    var filteredActivities: [Activity] {
        if category.isEmpty {
            return activities
        } else {
            return activities.filter { $0.category == category }
        }
    }
    
    func fetchCategories() {
        getCategories { categories, error in
            DispatchQueue.main.async {
                if let data = categories {
                    self.categoryList = data
                } else if let error = error {
                    print("Error: \(error)")
                }
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("ACTIVITY_CATEGORY", selection: $category) {
                    Text("ACTIVITY_CATEGORY_ALL").tag("")
                    ForEach(categoryList, id: \.self) { category in
                        Text(category).tag(category)
                    }
                }
                .padding()

                List {
                    ForEach(filteredActivities, id: \.id) { activity in
                        NavigationLink(destination: ActivityView(activity: activity)) {
                            ActivityComponentView(activity: activity)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("ACTIVITY_TITLE")
            .navigationBarBackButtonHidden(true)
            .onAppear {
                fetchCategories()
            }
        }
    }
}

#Preview {
    let fetcher = ActivityFetcher()
    return ActivityListView(activities: fetcher.data)
}
