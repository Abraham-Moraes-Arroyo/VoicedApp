//
//  RegistrationViewModel.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 3/19/24.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    
    func createUser() async throws {
        try await AuthService.shared.createUser(email: email, password: password, username: username)
        
        username = ""
        email = ""
        password = ""
        // resets values when creating another user
    }
}
