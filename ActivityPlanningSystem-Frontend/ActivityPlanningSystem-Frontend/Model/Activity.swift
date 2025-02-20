//
//  Activity.swift
//  ActivityPlanningSystem-Frontend
//
//  Created by Ege Kara on 20.02.2025.
//

import Foundation

struct Activity : Codable {
    
    private let id : String
    private let activityName : String
    private let description : String
    private let category : String
    private let activityStartingDate : String
    private let activityStartingTime : String
    private let activityDurationEstimate : String
    private let lattitude : Double
    private let longitude : Double
    
    init(id: String, activityName: String, description: String, category: String, activityStartingDate: String, activityStartingTime: String, activityDurationEstimate: String, lattitude: Double, longitude: Double) {
        self.id = id
        self.activityName = activityName
        self.description = description
        self.category = category
        self.activityStartingDate = activityStartingDate
        self.activityStartingTime = activityStartingTime
        self.activityDurationEstimate = activityDurationEstimate
        self.lattitude = lattitude
        self.longitude = longitude
    }
}

struct ActivityRequest : Codable {
    
    private let activityName : String
    private let description : String
    private let category : String
    private let activityStartingDate : String
    private let activityStartingTime : String
    private let activityDurationEstimate : String
    private let lattitude : Double
    private let longitude : Double
    
    init(activityName: String, description: String, category: String, activityStartingDate: String, activityStartingTime: String, activityDurationEstimate: String, lattitude: Double, longitude: Double) {
        self.activityName = activityName
        self.description = description
        self.category = category
        self.activityStartingDate = activityStartingDate
        self.activityStartingTime = activityStartingTime
        self.activityDurationEstimate = activityDurationEstimate
        self.lattitude = lattitude
        self.longitude = longitude
    }
    
}

struct MarkModel : Codable {
    
    private let id : String
    private let lattitude : Double
    private let longitude : Double
    
    init(id: String, lattitude: Double, longitude: Double) {
        self.id = id
        self.lattitude = lattitude
        self.longitude = longitude
    }
    
}
