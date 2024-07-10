//
//  PostViewModel.swift
//  TechSocialMediaSwiftUI
//
//  Created by Jordan Fraughton on 7/9/24.
//

import Foundation

class PostViewModel: ObservableObject {
    let networkController = NetworkController()
    
    @Published var post: Post
    
    init(post: Post) {
        self.post = post
    }
    
    func deletPost() {
        Task { @MainActor in
            do {
                try await networkController.deletePost(postId: post.postid)
            } catch {
                print(error)
            }
        }
    }
}
