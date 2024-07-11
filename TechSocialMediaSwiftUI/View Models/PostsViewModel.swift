//
//  PostsViewModel.swift
//  TechSocialMediaSwiftUI
//
//  Created by Jordan Fraughton on 7/8/24.
//

import Foundation

enum LoadingState {
    case loadingNextPage
    case notLoading
    case noMoreData
}

class PostsViewModel: ObservableObject {
    let networkController = NetworkController()
    
    @Published var posts: [Post] = []
    @Published var showingNewPostCreator = false
    @Published var showingComments = false 
    @Published var state = LoadingState.notLoading
    @Published var currentPageNumber = 0
    
    func getPosts() {
        state = .loadingNextPage
        Task { @MainActor in
            do {
                let success = try await NetworkController().getPosts(pageNumber: currentPageNumber)
                if success {
                    posts.append(contentsOf: Post.loadedPosts)
                    currentPageNumber += 1
                    state = .notLoading
                }
                
                if Post.loadedPosts.isEmpty {
                    state = .noMoreData
                }
            } catch {
                print(error)
            }
        }
    }
    
    func reloadPosts() {
        posts = []
        state = .notLoading
        currentPageNumber = 0
    }
}
