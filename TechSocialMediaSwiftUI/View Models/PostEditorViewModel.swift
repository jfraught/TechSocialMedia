//
//  PostEditorViewModel.swift
//  TechSocialMediaSwiftUI
//
//  Created by Jordan Fraughton on 7/9/24.
//

import Foundation
import SwiftUI

class PostEditorViewModel: ObservableObject {
    let networkController = NetworkController()
    let post: Post?
    
    @Published var title = ""
    @Published var body = ""
    @Published var showingAlert = false
    @Published var isLoading = false
    
    init(existingPost: Post?) {
        post = existingPost
        if let post {
            self.title = post.title
            self.body = post.body
        }
    }
    
    @MainActor 
    func savePost(postid: Int?, title: String, body: String, dismiss: @escaping () -> Void ) {
        Task {
            do {
                isLoading = true
                var success = false
                if let postid {
                    success = try await networkController.updatePost(postid: postid, title: title, body: body)
                } else {
                    success = try await networkController.createPost(title: title, body: body)
                }
                if success {
                    dismiss()
                } 
            } catch {
                isLoading = false
                showingAlert = true
                print(error)
            }
        }
    }
}
