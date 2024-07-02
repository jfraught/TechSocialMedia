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
            ProfileView(viewModel: ProfileViewModel())
        } else if session.appState == .loggedOut {
            LoginView(viewModel: LoginViewModel(session: session))
        }
    }
}

#Preview {
    AppView(session: AppViewModel())
}
