//
//  User.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 3/12/24.
//

import Foundation
struct User: Identifiable, Codable, Hashable {
    let id: String
    var username: String
    var profileImageUrl: String?
    var bio: String?
    let email: String
    
}
extension User {
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, username: "alex", profileImageUrl: "image-alex", bio: "Hi", email: "alex@example.com"),
        
        .init(id: NSUUID().uuidString, username: "jason", profileImageUrl: "image-jason", bio: "Hi I'm Jason", email: "jason@example.com"),
        
        .init(id: NSUUID().uuidString, username: "marcial", profileImageUrl: "image-marcial", bio: "Hi Im Marcial", email: "marcial@example.com"),
        
            .init(id: NSUUID().uuidString, username: "joanna", profileImageUrl: "image-joanna", bio: "Test bio", email: "joanna@example.com")
    
    ]
}

