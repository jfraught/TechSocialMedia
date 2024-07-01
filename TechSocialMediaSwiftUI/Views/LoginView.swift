//
//  LoginView.swift
//  TechSocialMediaSwiftUI
//
//  Created by Jordan Fraughton on 7/1/24.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack {
            Text("Tech Social Media")
                .font(.title)
            
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(.roundedBorder)
            
            TextField("Password", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)
            
            Text(viewModel.emailOrPasswordError)
                .foregroundStyle(.red)
            
            Button {
                viewModel.signIn()
            } label: {
                Text("Sign In")
            }
            .padding(.top, 100)
        }
        .padding()
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel(session: AppViewModel()))
}
