//
//  CommentsView.swift
//  TechSocialMediaSwiftUI
//
//  Created by Jordan Fraughton on 7/10/24.
//

import SwiftUI

struct CommentsView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var commentsViewModel: CommentsViewModel
    
    
    var body: some View {
        NavigationStack {
            List {
                if !commentsViewModel.comments.isEmpty {
                    ForEach(commentsViewModel.comments, id: \.commentId) { comment in
                        Section {
                            Text(comment.body)
                            
                            HStack {
                                Text(comment.userName)
                                    .font(.caption)
                                Text(comment.createdDate, format: .dateTime.day().month().year())
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                Spacer()
                            }
                        }
                    }
                } else {
                    Section {
                        EmptyView()
                    } header: {
                        Text("No comments")
                    }
                }
                switch commentsViewModel.state {
                case .loadingNextPage:
                    ProgressView()
                        .progressViewStyle(.circular)
                case .notLoading:
                    ProgressView()
                        .progressViewStyle(.circular)
                        .onAppear {
                            commentsViewModel.getComments()
                        }
                case .noMoreData:
                    EmptyView()
                }
            }
            .listStyle(.grouped)
            .listSectionSpacing(10)
            .sheet(isPresented: $commentsViewModel.showingNewCommentCreator) {
                NewCommentView(commentsViewModel: commentsViewModel)
            }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Dismiss")
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        commentsViewModel.showingNewCommentCreator.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationTitle("Comments")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}
