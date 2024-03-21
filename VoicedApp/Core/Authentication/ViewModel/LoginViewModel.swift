//
//  LoginViewModel.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 3/20/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signIn()  async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
}
