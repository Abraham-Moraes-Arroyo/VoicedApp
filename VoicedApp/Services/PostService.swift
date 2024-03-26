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


// likes

extension PostService {
    static func likePost(_ post: Post) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        async let _ = try await postsCollection.document(post.id).collection("post-likes").document(uid).setData([:])
        async let _ = try await postsCollection.document(post.id).updateData(["likes": post.likes + 1])
        async let _ = Firestore.firestore().collection("users").document(uid).collection("user-likes").document(post.id).setData([:])
    }
    
    static func unlikePost(_ post: Post) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        async let _ = try await postsCollection.document(post.id).collection("post-likes").document(uid).delete()
        async let _ = try await postsCollection.document(post.id).updateData(["likes": post.likes - 1])
        async let _ = Firestore.firestore().collection("users").document(uid).collection("user-likes").document(post.id).delete()
    }
    
    static func checkIfUserLikedPost(_ post: Post) async throws -> Bool {
        guard let uid = Auth.auth().currentUser?.uid else { return false }
        let snapshot = try await Firestore.firestore().collection("users").document(uid).collection("user-likes").document(post.id).getDocument()
        return snapshot.exists
        
    }
}

    // to do: dislikes
