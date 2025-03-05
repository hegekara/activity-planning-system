//
//  MapView.swift
//  ActivityPlanningSystem-Frontend
//
//  Created by Ege Kara on 19.02.2025.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @ObservedObject var fetcher : ActivityFetcher
    
    func locationConverter(latitude : Double, longitude : Double) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Map(position: $position){
                    ForEach(fetcher.data) { activity in
                        Annotation(activity.activityName,
                                   coordinate: locationConverter(latitude: activity.latitude, longitude: activity.longitude)) {
                            VStack {
                                
                                NavigationLink(destination: ActivityView(activity: activity)){
                                    Image(systemName: "mappin.circle.fill")
                                        .font(.title)
                                        .foregroundColor(.red)
                                    
                                }
                            }
                        }
                    }
                }
                    .onAppear {
                        CLLocationManager().requestWhenInUseAuthorization()
                    }
                    .mapStyle(.standard(pointsOfInterest: .excludingAll))
                    .mapControls {
                        MapUserLocationButton()
                        MapCompass()
                        MapPitchToggle()
                    }
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        NavigationLink(destination: CreateActivityView()) {
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(Circle().fill(Color.blue))
                                .shadow(radius: 5)
                        }
                        .padding()
                    }
                }
            }
            .navigationBarHidden(true)
            .onAppear(){
                fetcher.fetchActivities()
            }
        }
    }
}

#Preview {
    let fetcher = ActivityFetcher()
    MapView(fetcher: fetcher)
}
