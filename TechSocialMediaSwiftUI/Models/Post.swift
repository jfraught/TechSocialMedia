//
//  Post.swift
//  TechSocialMediaSwiftUI
//
//  Created by Jordan Fraughton on 7/8/24.
//

import Foundation

struct Post: Codable {
    var postid: UUID
    var title: String
    var body: String
    var authorUserName: String
    var autherUserID: UUID
    var likes: Int
    var userLiked: Bool
    var numComments: Int
    var createdDate: Date
}
