//
//  ActivityComponentView.swift
//  ActivityPlanningSystem-Frontend
//
//  Created by Ege Kara on 23.02.2025.
//

import SwiftUI

struct ActivityComponentView: View {
    
    @State var activity : Activity
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                
                Text(activity.category)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            
            Text(activity.activityName)
                .fontWeight(.heavy)
                .font(.title)
            
            Text(activity.description)
        }
        .padding(3)
    }
}

#Preview (traits: .sizeThatFitsLayout) {
    
    let activity = Activity(id: UUID(), activityName: "Derbi", description: "Galatasarayın ev sahipliği yapacağı GS-FB Derbisi", category: "SPORT", activityStartingDate: "12-04-2004", activityStartingTime: "08:00:00", activityDurationEstimate: 120, latitude: 40, longitude: 30)
    
    ActivityComponentView(activity: activity)
}
