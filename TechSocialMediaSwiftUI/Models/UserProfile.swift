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
    var userUUID: String
    var bio: String?
    var techInterests: [String]?
    
    static var current: UserProfile?
}
