//
//  AuthModel.swift
//  ActivityPlanningSystem-Frontend
//
//  Created by Ege Kara on 13.02.2025.
//

import Foundation


struct AuthRequest: Codable {
    let username : String
    let password : String
}

struct AuthResponse: Codable {
    let id : String
    let token : String
    let message : String
}
