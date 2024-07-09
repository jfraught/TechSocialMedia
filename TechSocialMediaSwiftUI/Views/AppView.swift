//
//  AppView.swift
//  TechSocialMediaSwiftUI
//
//  Created by Jordan Fraughton on 7/1/24.
//

import SwiftUI

struct AppView: View {
    @ObservedObject var session: AppViewModel

    var body: some View {
        if session.appState == .loggedIn {
            TabView() {
                ProfileView(viewModel: ProfileViewModel())
                    .tabItem {
                        Label("Profile", systemImage:  "person.crop.circle")
                    }
                
                PostsView(viewModel: PostsViewModel())
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
