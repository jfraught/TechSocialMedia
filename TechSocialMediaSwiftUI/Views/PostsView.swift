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
    @State private var showingNewPostCreator = false
    
    var body: some View {
        NavigationStack {
            List {
                Text("Test")
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Posts")
                        .font(.headline)
                        .foregroundStyle(.white)
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingNewPostCreator.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.white)
                    }
                    .sheet(isPresented: $showingNewPostCreator) {
                        PostEditorView(postEditorViewModel: PostEditorViewModel(existingPost: nil), profileViewModel: profileViewModel)
                    }
                }
    
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.MTECH, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    PostsView(postsViewModel: PostsViewModel(), profileViewModel: ProfileViewModel())
}
