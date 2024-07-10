//
//  AppView.swift
//  TechSocialMediaSwiftUI
//
//  Created by Jordan Fraughton on 7/1/24.
//

import SwiftUI

struct AppView: View {
    @ObservedObject var session: AppViewModel
    @StateObject var profileViewModel = ProfileViewModel()
    @StateObject var postsViewModel = PostsViewModel()
    
    var body: some View {
        if session.appState == .loggedIn {
            TabView() {
                ProfileView(profileViewModel: profileViewModel, postsViewModel: postsViewModel)
                    .tabItem {
                        Label("Profile", systemImage:  "person.crop.circle")
                    }
                
                PostsView(postsViewModel: postsViewModel, profileViewModel: profileViewModel)
                    .tabItem {
                        Label("Posts", systemImage:  "signpost.right")
                    }
            }
        } else if session.appState == .loggedOut {
            LoginView(viewModel: LoginViewModel(session: session))
        }
    }
}

#Preview {
    AppView(session: AppViewModel())
}
