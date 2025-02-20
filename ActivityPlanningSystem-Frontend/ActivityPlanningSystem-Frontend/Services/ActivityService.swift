//
//  ActivityService.swift
//  ActivityPlanningSystem-Frontend
//
//  Created by Ege Kara on 19.02.2025.
//

import Foundation

private let baseUrl = "http://localhost:8090/activity"

private func getAllActivities(completion: @escaping (Activity?, Error?) -> Void) {
    
    let url = URL(string: "\(baseUrl)/all")
    
    let task = URLSession.shared.dataTask(with: url!) {data, response, error in
        
        if let data = data{
            do {
                let activity = try JSONDecoder().decode(Activity.self, from: data)
                
                return completion(activity,nil)
                
            } catch {
                print("JSON decode error : \(error)")
                return completion(nil, URLError(.badServerResponse))
            }
        }
    }
    
    task.resume()
}


private func createActivity(
    activityName : String,
    description : String,
    category : String,
    activityStartingDate : String,
    activityStartingTime : String,
    activityDurationEstimate : String,
    lattitude : Double,
    longitude : Double,
    completion: @escaping (Activity?, Error?) -> Void) {
    
    let url = URL(string: "\(baseUrl)/create")
    
    var request = URLRequest(url: url!)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let activityData = ActivityRequest(
        activityName : activityName,
        description : description,
        category : category,
        activityStartingDate : activityStartingDate,
        activityStartingTime : activityStartingTime,
        activityDurationEstimate : activityDurationEstimate,
        lattitude : lattitude,
        longitude : longitude
    )
    
    do {
        request.httpBody = try JSONEncoder().encode(activityData)
    } catch {
        completion(nil, error)
        return
    }
    
    let task = URLSession.shared.dataTask(with: url!) {data, response, error in
        
        if let data = data{
            do {
                let activity = try JSONDecoder().decode(Activity.self, from: data)
                
                return completion(activity,nil)
                
            } catch {
                print("JSON decode error : \(error)")
                return completion(nil, URLError(.badServerResponse))
            }
        }
    }
    
    task.resume()
}
