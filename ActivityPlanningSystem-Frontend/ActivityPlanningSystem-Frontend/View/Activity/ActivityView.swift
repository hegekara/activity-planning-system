//
//  ActivityView.swift
//  ActivityPlanningSystem-Frontend
//
//  Created by Ege Kara on 23.02.2025.
//

import SwiftUI
import MapKit

struct ActivityView: View {
    
    @State var activity : Activity
    @State var estimatedHr : Int = 0
    @State var estimatedMin : Int = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(activity.id.uuidString)
                .fontWeight(.light)
                .font(.caption2)
                .foregroundStyle(.gray)
            
            HStack {
                VStack(alignment: .leading){
                    Text(activity.activityStartingDate)
                    Text(activity.activityStartingTime)
                    Text("Estimated Time: \(estimatedHr) hr \(estimatedMin) min")
                }
                
                Spacer()
                    
                Text(activity.category)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .padding(.top)
            
            Text(activity.activityName)
                .fontWeight(.heavy)
                .padding(.top)
                .font(.title)
            
            Text(activity.description)
            
            Map(position: .constant(.automatic)){
                Marker(activity.activityName, coordinate: CLLocationCoordinate2D(latitude: activity.latitude, longitude: activity.longitude))
            }
                .mapStyle(.standard(pointsOfInterest: .excludingAll))
                .mapControls {
                    MapCompass()
                }
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
        }
        .navigationTitle("Activity Detail")
        .padding(25)
        .onAppear(){
            updateEstimatedTime()
        }
    }
    private func updateEstimatedTime() {
        estimatedHr = Int(activity.activityDurationEstimate) / 60
        estimatedMin = Int(activity.activityDurationEstimate) % 60
    }
}

#Preview {
    let activity = Activity(id: UUID(), activityName: "Derbi", description: "Galatasarayın ev sahipliği yapacağı GS-FB Derbisi", category: "SPORT", activityStartingDate: "12-04-2004", activityStartingTime: "08:00:00", activityDurationEstimate: 120, latitude: 40, longitude: 30)
    
    ActivityView(activity: activity)
}
