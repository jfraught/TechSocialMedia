//
//  AppViewModel.swift
//  TechSocialMediaSwiftUI
//
//  Created by Jordan Fraughton on 7/1/24.
//

import Foundation

class AppViewModel: ObservableObject {
    @Published var appState: AppState = .loggedOut
}

enum AppState {
    case loggedIn
    case loggedOut
}
