//
//  AppView.swift
//  TechSocialMediaSwiftUI
//
//  Created by Jordan Fraughton on 7/1/24.
//

import SwiftUI

struct AppView: View {
    @ObservedObject var session: AppViewModel
    let profileViewModel = ProfileViewModel()
    var body: some View {
        if session.appState == .loggedIn {
            TabView() {
                ProfileView(viewModel: profileViewModel)
                    .tabItem {
                        Label("Profile", systemImage:  "person.crop.circle")
                    }
                
                PostsView(postsViewModel: PostsViewModel(), profileViewModel: profileViewModel)
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
