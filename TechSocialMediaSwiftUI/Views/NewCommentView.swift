//
//  NewCommentView.swift
//  TechSocialMediaSwiftUI
//
//  Created by Jordan Fraughton on 7/10/24.
//

import SwiftUI

struct NewCommentView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var commentsViewModel: CommentsViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Comment", text: $commentsViewModel.commentBody, axis: .vertical)
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
                        guard !commentsViewModel.commentBody.isEmpty else { return }
                        
                        commentsViewModel.saveComment(dismiss: { dismiss() })
                    } label: {
                        Text("Save")
                            .foregroundStyle(.blue)
                    }
                    .alert("Failed to save.", isPresented: $commentsViewModel.showingAlert) {
                        Button("OK", role: .cancel) {}
                    } message: {
                        Text("The comment was not saved.")
                    }
                }
            }
            .navigationTitle("New Comment")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}
