//
//  ProfileView.swift
//  TechSocialMediaSwiftUI
//
//  Created by Jordan Fraughton on 7/1/24.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text(viewModel.userName)
                        .fontWeight(.bold)
                    
                    Text(viewModel.firstName)
                    
                    Text(viewModel.lastName)
                } header: {
                    Text("Names")
                }
                
                Section {
                    if viewModel.bio.isEmpty {
                        Text("Bio is empty")
                            .foregroundStyle(.secondary)
                    } else {
                        Text(viewModel.bio)
                    }
                    
                    if viewModel.bio.isEmpty {
                        Text("Tech interesests is empty")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(viewModel.techIterests, id: \.self) { techInterest in
                            Text(techInterest)
                        }
                    }
                } header: {
                    Text("About")
                }
                
                Group {
                    if viewModel.posts.isEmpty {
                        Section {
                            Text("No user posts")
                                .foregroundStyle(.secondary)
                        } header: {
                            Text("User Posts")
                        }
                    } else {
                        ForEach(viewModel.posts, id: \.postid) { post in
                            Section {
                                PostView(postViewModel: PostViewModel(post: post), profileViewModel: viewModel)
                            } header: {
                                if viewModel.posts[0].postid == post.postid {
                                    Text("User Posts")
                                }
                            }
                        }
                    }
                }
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
            viewModel.getUserProfile()
        }
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel())
}
