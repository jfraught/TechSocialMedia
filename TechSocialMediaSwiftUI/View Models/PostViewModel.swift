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
    @Published var postIsLiked: Bool
    
    init(post: Post) {
        self.post = post
        self.postIsLiked = post.userLiked
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
    
    func likePost() {
        Task { @MainActor in
            do {
                let updatedPost = try await networkController.likePost(postid: post.postid)
                post = updatedPost
                postIsLiked =  post.userLiked
            } catch {
                throw error
            }
        }
    }
}
