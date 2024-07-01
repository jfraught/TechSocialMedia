//
//  LoginViewModel.swift
//  TechSocialMediaSwiftUI
//
//  Created by Jordan Fraughton on 7/1/24.
//

import Foundation

@MainActor
class LoginViewModel: ObservableObject {
    let authenticationController = AuthenticationController()
    var session: AppViewModel
    
    @Published var email: String = "jordan.fraughton2515@stu.mtec.edu"
    @Published var password: String = "qoxri1-pupbov-muskuG"
    @Published var emailOrPasswordError = ""
    
    init(session: AppViewModel) {
        self.session = session
    }
    
    func signIn() {
        guard !email.isEmpty, !password.isEmpty else { return }
        Task {
            do {
                let success = try await authenticationController.signIn(email: email, password: password)
                if success {
                    emailOrPasswordError = ""
                    session.appState = .loggedIn
                }
            } catch {
                print(error)
                emailOrPasswordError = "Invalid email or password"
            }
        }
    }
}
