//
//  AuthService.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 3/19/24.
//

// has all the functions related to authenticating a user when a user registers

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import Firebase

class AuthService {
    
    // user session routes the user based on if they are logged in / signed out
    @Published var userSession: FirebaseAuth.User?
    
    @Published var currentUser: User?
    
    static let shared = AuthService()
    
    
    init() {
        Task { try await loadUserData() }
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await loadUserData()
        } catch {
            print("DEBUG: failed to login with error \(error.localizedDescription)")
        }
    }
    
    @MainActor
        func createUser(email: String, password: String, username: String, additionalData: [String: Any]) async throws {
            do {
                let result = try await Auth.auth().createUser(withEmail: email, password: password)
                self.userSession = result.user
                // Now passing additionalData along with basic user info
                await uploadUserData(uid: result.user.uid, username: username, email: email, additionalData: additionalData)
            } catch {
                print("DEBUG: Failed to register with error \(error.localizedDescription)")
            }
        }
        
    
    @MainActor
    func loadUserData() async throws {
        self.userSession = Auth.auth().currentUser
        guard let currentUid = userSession?.uid else { return }
        self.currentUser = try await UserService.fetchUser(withUid: currentUid)
        
        
        // here the user object is being decoded
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
        self.currentUser = nil
        
    }
    
    private func uploadUserData(uid: String, username: String, email: String, additionalData: [String: Any]) async {
            var userDict: [String: Any] = [
                "id": uid,
                "username": username,
                "email": email
            ]
            // Add the additional registration data to the dictionary
            additionalData.forEach { key, value in
                userDict[key] = value
            }
    
            try? await Firestore.firestore().collection("users").document(uid).setData(userDict)
        }
    }
