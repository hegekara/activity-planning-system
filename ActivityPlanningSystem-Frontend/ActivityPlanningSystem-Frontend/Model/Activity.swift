//
//  Activity.swift
//  ActivityPlanningSystem-Frontend
//
//  Created by Ege Kara on 20.02.2025.
//

import Foundation

struct Activity : Codable , Identifiable {
    
    let id : UUID
    let activityName : String
    let description : String
    let category : String
    let activityStartingDate : String
    let activityStartingTime : String
    let activityDurationEstimate : Int32
    let latitude : Double
    let longitude : Double
    
    init(id: UUID, activityName: String, description: String, category: String, activityStartingDate: String, activityStartingTime: String, activityDurationEstimate: Int32, latitude: Double, longitude: Double) {
        self.id = id
        self.activityName = activityName
        self.description = description
        self.category = category
        self.activityStartingDate = activityStartingDate
        self.activityStartingTime = activityStartingTime
        self.activityDurationEstimate = activityDurationEstimate
        self.latitude = latitude
        self.longitude = longitude
    }
}

struct ActivityRequest : Codable {
    
    private let activityName : String
    private let description : String
    private let category : String
    private let activityStartingDate : String
    private let activityStartingTime : String
    private let activityDurationEstimate : Int32
    private let latitude : Double
    private let longitude : Double
    
    init(activityName: String, description: String, category: String, activityStartingDate: String, activityStartingTime: String, activityDurationEstimate: Int32, latitude: Double, longitude: Double) {
        self.activityName = activityName
        self.description = description
        self.category = category
        self.activityStartingDate = activityStartingDate
        self.activityStartingTime = activityStartingTime
        self.activityDurationEstimate = activityDurationEstimate
        self.latitude = latitude
        self.longitude = longitude
    }
    
}

struct MarkModel : Codable {
    
    private let id : String
    private let latitude : Double
    private let longitude : Double
    
    init(id: String, lattitude: Double, longitude: Double) {
        self.id = id
        self.latitude = lattitude
        self.longitude = longitude
    }
    
}
