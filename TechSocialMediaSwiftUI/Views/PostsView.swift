//
//  PostsView.swift
//  TechSocialMediaSwiftUI
//
//  Created by Jordan Fraughton on 7/8/24.
//

import SwiftUI

struct PostsView: View {
    @ObservedObject var postsViewModel: PostsViewModel
    @ObservedObject var profileViewModel: ProfileViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(postsViewModel.posts, id: \.postid) { post in
                    Section {
                        PostView(postViewModel: PostViewModel(post: post), profileViewModel: profileViewModel, postsViewModel: postsViewModel)
                    }
                }
                switch postsViewModel.state {
                case .loadingNextPage:
                    ProgressView()
                        .progressViewStyle(.circular)
                case .notLoading:
                    ProgressView()
                        .progressViewStyle(.circular)
                        .onAppear {
                            postsViewModel.getPosts()
                        }
                case .noMoreData:
                    EmptyView()
                }
            }
            .listSectionSpacing(10)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Posts")
                        .font(.headline)
                        .foregroundStyle(.white)
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        postsViewModel.showingNewPostCreator.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.white)
                    }
                    .sheet(isPresented: $postsViewModel.showingNewPostCreator, onDismiss: { postsViewModel.reloadPosts() }) {
                        PostEditorView(postEditorViewModel: PostEditorViewModel(existingPost: nil), profileViewModel: profileViewModel)
                    }
                }
    
            }
            .sheet(isPresented: $postsViewModel.showingComments, onDismiss: { postsViewModel.reloadPosts() }, content: {
                CommentsView(commentsViewModel: CommentsViewModel())
            })
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.MTECH, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    PostsView(postsViewModel: PostsViewModel(), profileViewModel: ProfileViewModel())
}
