//
//  ProfileView.swift
//  TechSocialMediaSwiftUI
//
//  Created by Jordan Fraughton on 7/1/24.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var profileViewModel: ProfileViewModel
    @ObservedObject var postsViewModel: PostsViewModel
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text(profileViewModel.userName)
                        .fontWeight(.bold)
                    
                    Text(profileViewModel.firstName)
                    
                    Text(profileViewModel.lastName)
                } header: {
                    Text("Names")
                }
                
                Section {
                    if profileViewModel.bio.isEmpty {
                        Text("Bio is empty")
                            .foregroundStyle(.secondary)
                    } else {
                        Text(profileViewModel.bio)
                    }
                    
                    if profileViewModel.bio.isEmpty {
                        Text("Tech interesests is empty")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(profileViewModel.techIterests, id: \.self) { techInterest in
                            Text(techInterest)
                        }
                    }
                } header: {
                    Text("About")
                }
                
                Group {
                    if profileViewModel.posts.isEmpty {
                        Section {
                            Text("No user posts")
                                .foregroundStyle(.secondary)
                        } header: {
                            Text("User Posts")
                        }
                    } else {
                        ForEach(profileViewModel.posts, id: \.postid) { post in
                            Section {
                                PostView(postViewModel: PostViewModel(post: post), profileViewModel: profileViewModel, postsViewModel: postsViewModel)
                            } header: {
                                if profileViewModel.posts[0].postid == post.postid {
                                    Text("User Posts")
                                }
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $profileViewModel.showingNewPostCreator, onDismiss: { postsViewModel.reloadPosts() }) {
                PostEditorView(postEditorViewModel: PostEditorViewModel(existingPost: profileViewModel.postToBeEditted), profileViewModel: profileViewModel)
            }
            .listSectionSpacing(10)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Profile")
                        .font(.headline)
                        .foregroundStyle(.white)
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        
                    } label: {
                        Text("Edit")
                            .foregroundStyle(.white)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.MTECH, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .onAppear {
            profileViewModel.getUserProfile()
        }
    }
}

#Preview {
    ProfileView(profileViewModel: ProfileViewModel(), postsViewModel: PostsViewModel())
}
