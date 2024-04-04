//
//  PostReplyService.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 4/2/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


struct PostReplyService {
    
    private static let postsReplyCollection = Firestore.firestore().collection("replies")
    private static let postsCollection = Firestore.firestore().collection("posts")
     
    static func uploadPostReply(_ reply: PostReply, toPost post: Post) async throws {
        guard let replyData = try? Firestore.Encoder().encode(reply) else { return }
        
        async let _ = try await postsReplyCollection.document().setData(replyData)
        async let _ = try await postsCollection.document(post.id).updateData([
            "comments" : post.comments + 1
        ])
    }
}
