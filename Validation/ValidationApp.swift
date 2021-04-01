//
//  ValidationApp.swift
//  Validation
//
//  Created by Oleg Marchik on 25.03.21.
//

import SwiftUI

@main
struct ValidationApp: App {
    var body: some Scene {
        WindowGroup {
            RegistrationView(viewModel: .init())
        }
    }
}
