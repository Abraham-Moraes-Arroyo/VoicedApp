//
//  ForumCellViewModel.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 3/25/24.
//

import Foundation

@MainActor
class ForumCellViewModel: ObservableObject {
    @Published var post: Post
    
    init(post: Post) {
        self.post = post
        Task { try await checkIfUserLikedPost()
               try await checkIfUserBookmarkedPost()
               try await checkIfUserDislikedPost()
        }
    }
    
    func like() async throws {
        
        do {
            // post copy contains the original amount of likes
            let postCopy = post
            post.didLike = true
            post.likes += 1
            
            try await PostService.likePost(postCopy)
            
        } catch {
            post.didLike = false
            post.likes -= 1
        }
    }
    
    func unlike() async throws {
        do {
            // post copy contains the original amount of likes
            let postCopy = post
            post.didLike = false
            post.likes -= 1
            
            try await PostService.unlikePost(postCopy)
            
        } catch {
            post.didLike = true
            post.likes += 1
        }
    }
    
    func dislike() async throws {
        
        do {
            // post copy contains the original amount of likes
            let postCopy = post
            post.didDislike = true
            post.dislikes += 1
            
            try await PostService.dislikePost(postCopy)
            
        } catch {
            post.didDislike = false
            post.dislikes -= 1
        }
    }
    
    func undoDislike() async throws {
        
        do {
            // post copy contains the original amount of likes
            let postCopy = post
            post.didDislike = false
            post.dislikes -= 1
        
            try await PostService.undoDislikePost(postCopy)
        
        } catch {
            post.didDislike = true
            post.dislikes += 1
        }
    }
    
    func bookmark() async throws {
        do {
            // post copy contains the original amount of likes
            let postCopy = post
            post.didBookmark = true
            post.favorites += 1
            
            try await PostService.bookmarkPost(postCopy)
            
        } catch {
            post.didBookmark = false
            post.favorites -= 1
        }
    }
      
    
    func unbookmark() async throws {
        
        do {
            // post copy contains the original amount of likes
            let postCopy = post
            post.didBookmark = false
            post.favorites -= 1
            
            try await PostService.unbookmarkPost(postCopy)
            
        } catch {
            post.didBookmark = true
            post.favorites += 1
        }
    }
        
        
    
    func checkIfUserLikedPost() async throws {
        self.post.didLike = try await PostService.checkIfUserLikedPost(post)
    }
    
    func checkIfUserBookmarkedPost() async throws {
        self.post.didBookmark = try await PostService.checkIfUserBookmarkedPost(post)
    }
    
    func checkIfUserDislikedPost() async throws {
        self.post.didDislike = try await PostService.checkIfUserDislikedPost(post)
    }

}
