//
//  ActivityService.swift
//  ActivityPlanningSystem-Frontend
//
//  Created by Ege Kara on 19.02.2025.
//

import Foundation
import Combine

private let baseUrl = "http://localhost:8090/activity"


func createActivity(
    activityName : String,
    description : String,
    category : String,
    activityStartingDate : String,
    activityStartingTime : String,
    activityDurationEstimate : Int32,
    latitude : Double,
    longitude : Double,
    completion: @escaping (ActivityRequest?, Error?) -> Void) {
    
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
        latitude : latitude,
        longitude : longitude
    )
        
        print(activityData)
    
    do {
        request.httpBody = try JSONEncoder().encode(activityData)
    } catch {
        completion(nil, error)
        return
    }
    
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
        
        if let data = data{
            do {
                
                let activityResponse = try JSONDecoder().decode(ActivityRequest.self, from: data)
                
                return completion(activityResponse,nil)
                
            } catch {
                print("JSON decode error : \(error)")
                return completion(nil, URLError(.badServerResponse))
            }
        }
    }
    
    task.resume()
}



func getCategories(completion: @escaping ([String]?, Error?) -> Void) {
    guard let url = URL(string: "\(baseUrl)/categories") else {
        completion(nil, URLError(.badURL))
        return
    }
    
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(nil, error)
            return
        }
        
        guard let data = data else {
            completion(nil, URLError(.badServerResponse))
            return
        }
        
        do {
            let categories = try JSONDecoder().decode([String].self, from: data)
            completion(categories, nil)
        } catch {
            print("JSON decode error: \(error)")
            completion(nil, error)
        }
    }
    
    task.resume()
}


func getActivities(completion: @escaping ([Activity]?, Error?) -> Void) {
    guard let url = URL(string: "\(baseUrl)/all") else {
        completion(nil, URLError(.badURL))
        return
    }
    
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(nil, error)
            return
        }
        
        guard let data = data else {
            completion(nil, URLError(.badServerResponse))
            return
        }
        
        do {
            let activities = try JSONDecoder().decode([Activity].self, from: data)
            completion(activities, nil)
        } catch {
            print("JSON decode error: \(error)")
            completion(nil, error)
        }
    }
    
    task.resume()
}


class ActivityFetcher : ObservableObject {
    @Published var data : [Activity] = []
    @Published var isLoading : Bool = false
    
    func fetchActivities(){
        guard !isLoading else {return}
        isLoading = true
        
        getActivities{ response, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    print("Error while fetching activities : \(error)")
                    return
                }
                
                if let response = response {
                    self.data = response
                    
                    if self.data.isEmpty{
                        print("Activity list is empty")
                    }
                    return
                }
            }
        }
    }
}
