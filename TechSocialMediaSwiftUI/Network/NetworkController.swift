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
        case couldNotSavePost
        case couldNotDeletPost
        case couldNotGetPosts
        case couldNotGetComments
        case couldNotPostComment
    }
    
    let decoder = JSONDecoder()
    let session = URLSession.shared
    
    func signIn(email: String, password: String) async throws -> Bool {
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
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let user = User.current else { throw NetworkError.noCurrentUser }
        
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
    
    func createPost(title: String, body: String) async throws -> Bool {
        guard let user = User.current else { throw NetworkError.noCurrentUser }
        
        var request = URLRequest(url: URL(string: "\(API.url)/createPost")!)
        
        let body: [String: Any] = [ "userSecret": user.secret.uuidString, "post" : ["title": title, "body": body]]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (_, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.couldNotSavePost
        }
        
        return true
    }
    
    func getPosts(pageNumber: Int) async throws -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let user = User.current else { throw NetworkError.noCurrentUser }
        
        let queryItems = ["userSecret": user.secret.uuidString, "pageNumber": pageNumber.description]
        
        var urlComponents = URLComponents(string: "\(API.url)/posts")!
        urlComponents.queryItems = queryItems.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        var request = URLRequest(url: urlComponents.url!)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.couldNotGetPosts
        }
        
        let posts = try decoder.decode([Post].self, from: data)
        
        Post.loadedPosts = posts
        
        return true 
    }
    
    func updatePost(postid: Int, title: String, body: String) async throws -> Bool {
        guard let user = User.current else { throw NetworkError.noCurrentUser }
        
        var request = URLRequest(url: URL(string: "\(API.url)/editPost")!)
        
        let body: [String: Any] = [ "userSecret": user.secret.uuidString, "post" : ["postid": postid, "title": title, "body": body]]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (_, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.couldNotSavePost
        }
        
        return true
    }
    
    func deletePost(postId: Int) async throws {
        guard let user = User.current else { throw NetworkError.noCurrentUser }
        
        let queryItems = ["userSecret": user.secret.uuidString, "postid" : postId.description]
        var urlComponents = URLComponents(string: "\(API.url)/post")!
        urlComponents.queryItems = queryItems.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        var request = URLRequest(url: urlComponents.url!)
        
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (_, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.couldNotDeletPost
        }
    }
    
    func getComments(postid: Int, pageNumber: Int) async throws -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let user = User.current else { throw NetworkError.noCurrentUser }
        
        let queryItems = ["userSecret": user.secret.uuidString, "postid": postid.description,"pageNumber": pageNumber.description]
        
        var urlComponents = URLComponents(string: "\(API.url)/comments")!
        urlComponents.queryItems = queryItems.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        var request = URLRequest(url: urlComponents.url!)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.couldNotGetComments
        }
        
        let comments = try decoder.decode([Comment].self, from: data)
        
        Comment.loadedComments = comments
        
        return true 
    }
    
    func createComment(commentBody: String, postid: Int) async throws -> Comment {
        guard let user = User.current else { throw NetworkError.noCurrentUser }
        
        var request = URLRequest(url: URL(string: "\(API.url)/createComment")!)
        
        let body: [String: Any] = ["userSecret": user.secret.uuidString, "commentBody": commentBody, "postid": postid]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.couldNotPostComment
        }
        
        let newComment = try decoder.decode(Comment.self, from: data)
        
        return newComment
    }
    
    func likePost(postid: Int) async throws -> Post {
        guard let user = User.current else { throw NetworkError.noCurrentUser }
        
        var request = URLRequest(url: URL(string: "\(API.url)/updateLikes")!)
        
        let body: [String: Any] = ["userSecret": user.secret.uuidString, "postid": postid]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.couldNotPostComment
        }
        
        let postWitUpdatedLikes = try decoder.decode(Post.self, from: data)
        
        return postWitUpdatedLikes
    }
}
