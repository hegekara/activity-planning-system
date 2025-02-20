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
    
    var body: some View {
        ZStack {
            Map(position: $position)
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
                    
                    Button(action: {}, label: {
                        Image(systemName: "plus")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Circle().fill(Color.blue))
                            .shadow(radius: 5)
                    })
                    .padding()
                }
            }
        }
    }
}

#Preview {
    MapView()
}
