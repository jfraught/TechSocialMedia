//
//  CommentsViewModel.swift
//  TechSocialMediaSwiftUI
//
//  Created by Jordan Fraughton on 7/10/24.
//

import Foundation

class CommentsViewModel: ObservableObject {
    let networkController = NetworkController()
    var postid = Post.postidForComments
    
    @Published var comments = [Comment]()
    @Published var showingNewCommentCreator = false
    @Published var state = LoadingState.notLoading
    @Published var currentPageNumber = 0
    @Published var showingAlert = false 
    @Published var commentBody = ""
    
    func getComments() {
        state = .loadingNextPage
        Task { @MainActor in
            do {
                let success = try await networkController.getComments(postid: postid, pageNumber: currentPageNumber)
                if success {
                    comments.append(contentsOf: Comment.loadedComments)
                    currentPageNumber += 1
                    state = .notLoading
                }
                
                if Comment.loadedComments.isEmpty {
                    state = .noMoreData
                }
            } catch {
                print(error)
            }
        }
    }
    
    func saveComment(dismiss: @escaping () -> Void) {
        Task { @MainActor in
            do {
                let newComment = try await networkController.createComment(commentBody: commentBody, postid: Post.postidForComments)
                comments.append(newComment)
                dismiss()
            } catch {
                print(error)
                showingAlert = true 
            }
        }
    }
}
