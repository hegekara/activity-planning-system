//
//  AuthService.swift
//  ActivityPlanningSystem-Frontend
//
//  Created by Ege Kara on 13.02.2025.
//

import Foundation

private let baseUrl: String = "http://localhost:8090/auth"

private func performAuthRequest(endpoint: String, username: String, password: String, completion: @escaping (AuthResponse?, Error?) -> Void) {
    
    let urlString = "\(baseUrl)\(endpoint)"
    
    guard let url = URL(string: urlString) else {
        completion(nil, URLError(.badURL))
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    
    let authData = AuthRequest(username: username, password: password)
    
    do {
        request.httpBody = try JSONEncoder().encode(authData)
    } catch {
        completion(nil, error)
        return
    }
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(nil, error)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            completion(nil, URLError(.badServerResponse))
            return
        }
        
        if let data = data {
            do {
                let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
                completion(authResponse, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
    
    task.resume()
}

func login(username: String, password: String, completion: @escaping (AuthResponse?, Error?) -> Void) {
    performAuthRequest(endpoint: "/login", username: username, password: password, completion: completion)
}

func register(username: String, password: String, completion: @escaping (AuthResponse?, Error?) -> Void) {
    performAuthRequest(endpoint: "/register", username: username, password: password, completion: completion)
}
