//
//  ParticipationService.swift
//  ActivityPlanningSystem-Frontend
//
//  Created by Ege Kara on 27.02.2025.
//

import Foundation

private let baseUrl: String = "http://localhost:8090/participation"

func checkUserParticipate(userId : String, activityId : String, completion: @escaping (Error?) -> Void) {
    
    let urlString = "\(baseUrl)/check-user-participation"
    
    guard let url = URL(string: urlString) else{
        completion(URLError(.badURL))
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue(userId, forHTTPHeaderField: "userId")
    request.addValue(activityId, forHTTPHeaderField: "activityId")
    
    print(request)
    
    
    let task = URLSession.shared.dataTask(with: request) { _, response, error in
        if let error = error {
            completion(error)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            completion(URLError(.badServerResponse))
            return
        }
        
        completion(nil)
    }
    
    task.resume()
}


func registerActivity(userId : String, activityId : String, completion: @escaping (Error?) -> Void) {
    
    let urlString = "\(baseUrl)/register"
    
    guard let url = URL(string: urlString) else{
        completion(URLError(.badURL))
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue(userId, forHTTPHeaderField: "userId")
    request.addValue(activityId, forHTTPHeaderField: "activityId")
    
    print(request)
    
    
    let task = URLSession.shared.dataTask(with: request) { _, response, error in
        if let error = error {
            completion(error)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            completion(URLError(.badServerResponse))
            return
        }
        
        completion(nil)
    }
    
    task.resume()
}

func unregisterActivity(userId : String, activityId : String, completion: @escaping (Error?) -> Void) {
    
    let urlString = "\(baseUrl)/unregister"
    
    guard let url = URL(string: urlString) else{
        completion(URLError(.badURL))
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
    request.addValue(userId, forHTTPHeaderField: "userId")
    request.addValue(activityId, forHTTPHeaderField: "activityId")
    
    print(request)
    
    
    let task = URLSession.shared.dataTask(with: request) { _, response, error in
        if let error = error {
            completion(error)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            completion(URLError(.badServerResponse))
            return
        }
        
        completion(nil)
    }
    
    task.resume()
}


func getUserActivities(completion: @escaping ([Activity]?, Error?) -> Void) {
    
    let urlString = "\(baseUrl)/user"
    
    guard let url = URL(string: urlString) else{
        completion(nil, URLError(.badURL))
        return
    }
    
    guard let userId = getFromKeychain(key: "id") else {
        print("USER_ID_NOT_FOUND")
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue(userId, forHTTPHeaderField: "userId")
    
    print(request)
    
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(nil, error)
            return
        }
        
        guard let data = data else {
            completion(nil, URLError(.cannotDecodeRawData))
            return
        }
        
        do {
            let activities = try JSONDecoder().decode([Activity].self, from: data)
            completion(activities, nil)
        } catch {
            completion(nil, error)
        }
    }
    
    task.resume()
}
