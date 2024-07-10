//
//  PostView.swift
//  TechSocialMediaSwiftUI
//
//  Created by Jordan Fraughton on 7/8/24.
//

import SwiftUI

struct PostView: View {
    @ObservedObject var postViewModel: PostViewModel
    @ObservedObject var profileViewModel: ProfileViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(postViewModel.post.title)
                    .font(.headline)
                
                Spacer()
                
                Menu {
                    Button {
                        profileViewModel.showingNewPostCreator.toggle()
                        
                        profileViewModel.postToBeEditted = postViewModel.post
                    } label: {
                        Text("Edit")
                    }
                    
                    Button(role: .destructive) {
                        postViewModel.deletPost()
                        profileViewModel.getUserProfile()
                    } label: {
                        Text("Delete")
                    }
                } label: {
                    Image(systemName: "ellipsis")
                }
                .foregroundStyle(.secondary)
            }
            
            Text(postViewModel.post.body)
        }
        
        HStack {
            Text(postViewModel.post.authorUserName)
                .font(.caption)
            
            Text(postViewModel.post.createdDate, format: .dateTime.day().month().year())
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "heart")
            }
            .foregroundStyle(.black)
            
            Text("2")
            
            Button {
                
            } label: {
                Image(systemName: "bubble.right")
            }
            .foregroundStyle(.black)
            
            Text("1")
        }
    }
}
