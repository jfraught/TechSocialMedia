//
//  PostView.swift
//  TechSocialMediaSwiftUI
//
//  Created by Jordan Fraughton on 7/8/24.
//

import SwiftUI

struct PostView: View {
    var post: Post
    
    var body: some View {
        VStack {
            Text(post.title)
            HStack {
                Text(post.authorUserName)
                    .fontWeight(.bold)
                Text(post.createdDate.description)
                    .foregroundStyle(.secondary)
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis")
                }
                .foregroundStyle(.secondary)
            }
            Text(post.body)
        }
        HStack {
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
