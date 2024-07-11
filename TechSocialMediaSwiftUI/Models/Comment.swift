//
//  Comment.swift
//  TechSocialMediaSwiftUI
//
//  Created by Jordan Fraughton on 7/10/24.
//

import Foundation

struct Comment: Codable {
    var commentId: Int
    var body: String
    var userName: String
    var userId: UUID
    var createdDate: Date
    
    static var loadedComments = [Comment]()
}
