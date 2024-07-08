//
//  ProfileViewModel.swift
//  TechSocialMediaSwiftUI
//
//  Created by Jordan Fraughton on 7/1/24.
//

import Foundation

@MainActor
class ProfileViewModel: ObservableObject {
    let networkController = NetworkController()
    
    @Published var userName: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var bio: String = ""
    @Published var techIterests: [String] = []
    @Published var posts: [Post] = []
    
    func getUserProfile() {
        Task { @MainActor in
            do {
                let success = try await networkController.getUser()
                if success, let userProfile = UserProfile.current  {
                    userName = userProfile.userName
                    firstName = userProfile.firstName
                    lastName = userProfile.lastName
                    bio = userProfile.bio ?? ""
                    techIterests = userProfile.techInterests ?? []
                    posts = userProfile.posts ?? []
                }
            } catch {
                print(error)
            }
            
        }
    }
}
