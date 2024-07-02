//
//  NetworkController.swift
//  TechSocialMediaSwiftUI
//
//  Created by Jordan Fraughton on 7/1/24.
//

import Foundation

class NetworkController {
    enum NetworkError: Error, LocalizedError {
        case couldNotSignIn
        case noCurrentUser
        case couldNotGetUserProfile
    }
    
    let decoder = JSONDecoder()
    
    func signIn(email: String, password: String) async throws -> Bool {
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: "\(API.url)/signIn")!)
        
        let credentials: [String: Any] = ["email": email, "password": password]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: credentials, options: .prettyPrinted)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.couldNotSignIn
        }
        
        let user = try decoder.decode(User.self, from: data)
        
        User.current = user
        
        return true
    }
    
    func getUser() async throws -> Bool {
        guard let user = User.current else { throw NetworkError.noCurrentUser }
        let session = URLSession.shared
        let userIDs = ["userUUID": user.userUUID.uuidString, "userSecret": user.secret.uuidString]
        var urlComponents = URLComponents(string: "\(API.url)/userProfile")!
        urlComponents.queryItems = userIDs.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        var request = URLRequest(url: urlComponents.url!)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.couldNotGetUserProfile
        }
        
        let userProfile = try decoder.decode(UserProfile.self, from: data)

        UserProfile.current = userProfile
        
        return true 
    }
}
