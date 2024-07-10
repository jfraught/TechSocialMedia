//
//  PostEditorView.swift
//  TechSocialMediaSwiftUI
//
//  Created by Jordan Fraughton on 7/8/24.
//

import SwiftUI

struct PostEditorView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var postEditorViewModel: PostEditorViewModel
    @ObservedObject var profileViewModel: ProfileViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                if !postEditorViewModel.isLoading {
                    Form {
                        Section {
                            TextField("Title", text: $postEditorViewModel.title)
                        } header: {
                            Text("Title")
                        }
                        
                        Section {
                            TextField("What's new?", text: $postEditorViewModel.body, axis: .vertical)
                        } header: {
                            Text("Body")
                        }
                    }
                } else {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(.red)
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        guard !postEditorViewModel.title.isEmpty && !postEditorViewModel.body.isEmpty else { return }
                        
                        postEditorViewModel.savePost(postid: postEditorViewModel.post?.postid, title: postEditorViewModel.title, body: postEditorViewModel.body, dismiss: { dismiss() })
                        
                        profileViewModel.getUserProfile()
                    } label: {
                        Text("Save")
                            .foregroundStyle(.blue)
                    }
                    .alert("Failed to save.", isPresented: $postEditorViewModel.showingAlert) {
                        Button("OK", role: .cancel) {}
                    } message: {
                        Text("The post was not saved.")
                    }
                }
            }
            .navigationTitle(postEditorViewModel.title.isEmpty ? "New Post" : "Edit Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    PostEditorView(postEditorViewModel: PostEditorViewModel(existingPost: nil), profileViewModel: ProfileViewModel())
}
