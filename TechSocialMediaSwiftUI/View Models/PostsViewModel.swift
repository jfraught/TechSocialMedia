//
//  PostsViewModel.swift
//  TechSocialMediaSwiftUI
//
//  Created by Jordan Fraughton on 7/8/24.
//

import Foundation

class PostsViewModel: ObservableObject {
    let networkController = NetworkController()
    
    @Published var posts: [Post] = []
    
    func getPosts() {
        
    }
}
