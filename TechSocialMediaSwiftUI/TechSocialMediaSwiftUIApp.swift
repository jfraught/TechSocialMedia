//
//  TechSocialMediaSwiftUIApp.swift
//  TechSocialMediaSwiftUI
//
//  Created by Jordan Fraughton on 7/1/24.
//

import SwiftUI

@main
struct TechSocialMediaSwiftUIApp: App {
    let session = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            AppView(session: session)
        }
    }
}
