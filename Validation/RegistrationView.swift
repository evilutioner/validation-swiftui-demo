//
//  RegistrationView.swift
//  Validation
//
//  Created by Oleg Marchik on 25.03.21.
//

import SwiftUI

struct RegistrationView: View {
    @ObservedObject var viewModel: RegistrationViewModel
    
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $viewModel.username)
            }
            Section {
                SecureField("Password", text: $viewModel.password)
                SecureField("Verify Password", text: $viewModel.verifiedPassword)
            }
            Button("Create Account") { }
                .disabled(viewModel.createButtonIsDisabled)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(viewModel: .init())
    }
}
