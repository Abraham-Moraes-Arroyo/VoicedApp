//
//  PostService.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 3/24/24.
//


import Firebase

struct PostService {
    
    private static let postsCollection = Firestore.firestore().collection("posts")
    
    static func fetchForumPosts() async throws -> [Post] {
        let snapshot = try await postsCollection.getDocuments()
        var posts = try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
        
        for i in 0 ..< posts.count {
            let post = posts[i]
            guard let ownerUid = post.ownerUid else { return [] }
            let postUser = try await UserService.fetchUser(withUid: ownerUid)
            posts[i].user = postUser
        }
        
        return posts
        
    }
    
    
    static func fetchUserPosts(uid: String) async throws -> [Post] {
        // filtering documents by owner id
        let snapshot = try await postsCollection.whereField("ownerUid", isEqualTo: uid).getDocuments()
        return try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
        
        
    }
}

