//
//  AuthService.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 3/19/24.
//

// has all the functions related to authenticating a user when a user registers

import Foundation
import FirebaseAuth

class AuthService {
    
    // user session routes the user based on if they are logged in / signed out
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
        } catch {
            print("DEBUG: failed to login with error \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(email: String, password: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
        } catch {
            print("DEBUG: failed to register with error \(error.localizedDescription)")
        }
    }
    
    func loadUserData() async throws {
        
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
        
    }
    
}
