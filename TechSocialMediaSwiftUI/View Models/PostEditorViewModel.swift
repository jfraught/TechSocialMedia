//
//  PostEditorViewModel.swift
//  TechSocialMediaSwiftUI
//
//  Created by Jordan Fraughton on 7/9/24.
//

import Foundation
import SwiftUI

class PostEditorViewModel: ObservableObject {
    let networkController = NetworkController()
    
    @Published var title = ""
    @Published var body = ""
    @Published var showingAlert = false
    @Published var isLoading = false
    
    @MainActor func savePost(title: String, body: String, dismiss: @escaping () -> Void ) {
        Task {
            do {
                isLoading = true
                let success = try await networkController.createPost(title: title, body: body)
                if success {
                    dismiss()
                } 
            } catch {
                isLoading = false
                showingAlert = true
                print(error)
            }
        }
    }
}
