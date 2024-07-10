//
//  UserProfile.swift
//  TechSocialMediaSwiftUI
//
//  Created by Jordan Fraughton on 7/2/24.
//

import Foundation

struct UserProfile: Codable {
    var firstName: String
    var lastName: String
    var userName: String
    var userUUID: UUID
    var bio: String?
    var techInterests: [String]?
    var posts: [Post]?
    
    static var current: UserProfile?
}
