//
//  User.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 3/12/24.
//

import Foundation
import Firebase
struct User: Identifiable, Codable, Hashable {
    let id: String
    var username: String
    var profileImageUrl: String?
    var bio: String?
    let email: String
    
    // property can be used to determine whether to display edit profile or not
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        return currentUid == id
    }
    
}
extension User {
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, username: "alex", profileImageUrl: nil, bio: "Hi", email: "alex@example.com"),
        
        .init(id: NSUUID().uuidString, username: "jason", profileImageUrl: nil, bio: "Hi I'm Jason", email: "jason@example.com"),
        
        .init(id: NSUUID().uuidString, username: "marcial", profileImageUrl: nil, bio: "Hi Im Marcial", email: "marcial@example.com"),
        
            .init(id: NSUUID().uuidString, username: "joanna", profileImageUrl: nil, bio: "Test bio", email: "joanna@example.com")
    
    ]
}

