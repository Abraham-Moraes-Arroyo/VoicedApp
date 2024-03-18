//
//  Post.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 3/12/24.
//

import Foundation
struct Post: Identifiable, Hashable, Codable {
    let id: String
    let ownerUid: String
    let title: String
    let caption: String?
    var likes: Int
    var dislikes: Int
    let imageUrl: String?
    let timestamp: Date
    var user: User?
    var category: PostCategory
    private enum CodingKeys: String, CodingKey {
        case id, ownerUid, title, caption, likes, dislikes, imageUrl, timestamp, user, category
    }
    
    // Computed property to check if a post is user-generated.
        // This example assumes that if a post has an `ownerUid`, it's user-generated.
        // Adjust this logic based on your actual data model and requirements.
    var isUserGenerated: Bool {
            return !ownerUid.isEmpty
    }
}
extension Post {
    static let MOCK_POSTS: [Post] = [
        .init(id: UUID().uuidString,
              ownerUid: User.MOCK_USERS[0].id,
              title: "Community Cleanup Event",
              caption: "Join us this weekend for a community park cleanup.",
              likes: 120,
              dislikes: 10,
              imageUrl: "post-0",
              timestamp: Date(),
              user: User.MOCK_USERS[0],
              category: .events),
        .init(id: UUID().uuidString,
              ownerUid: User.MOCK_USERS[1].id,
              title: "Shocking Scene at the Neighborhood Festival!",
              caption: "What started as a fun-filled day ended in whispers and gasps as two well-known community members were overheard in a heated exchange behind the food stalls. Details are sparse, but rumors are swirling about a longstanding rivalry coming to light. Has anyone else heard more?",
              likes: 85,
              dislikes: 4,
              imageUrl: "post-1",
              timestamp: Date(),
              user: User.MOCK_USERS[1],
              category: .localNews),
        .init(id: UUID().uuidString,
              ownerUid: User.MOCK_USERS[2].id,
              title: "Education Reform Meeting",
              caption: "A meeting on the new education reforms will be held tomorrow.",
              likes: 95,
              dislikes: 4,
              imageUrl: "post-2",
              timestamp: Date(),
              user: User.MOCK_USERS[2],
              category: .other),
        .init(id: UUID().uuidString,
              ownerUid: User.MOCK_USERS[3].id,
              title: "Crime Watch Alert!",
              caption: "Be on the lookout for suspicious activities in our neighborhood.",
              likes: 150,
              dislikes: 6,
              imageUrl: "post-3",
              timestamp: Date(),
              user: User.MOCK_USERS[3],
              category: .reports)
    ]
}

