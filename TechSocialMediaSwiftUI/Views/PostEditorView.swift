//
//  PostEditorView.swift
//  TechSocialMediaSwiftUI
//
//  Created by Jordan Fraughton on 7/8/24.
//

import SwiftUI

struct PostEditorView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: PostEditorViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                if !viewModel.isLoading {
                    Form {
                        Section {
                            TextField("Title", text: $viewModel.title)
                        } header: {
                            Text("Title")
                        }
                        
                        Section {
                            TextField("What's new?", text: $viewModel.body, axis: .vertical)
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
                        guard !viewModel.title.isEmpty && !viewModel.body.isEmpty else { return }
                        viewModel.savePost(title: viewModel.title, body: viewModel.body, dismiss: { dismiss() })
                    } label: {
                        Text("Save")
                            .foregroundStyle(.blue)
                    }
                    .alert("Failed to save.", isPresented: $viewModel.showingAlert) {
                        Button("OK", role: .cancel) {}
                    } message: {
                        Text("The post was not saved.")
                    }
                }
            }
            .navigationTitle("New Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    PostEditorView(viewModel: PostEditorViewModel())
}
