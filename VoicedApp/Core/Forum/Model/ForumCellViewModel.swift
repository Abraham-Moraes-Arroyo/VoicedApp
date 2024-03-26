//
//  ForumCellViewModel.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 3/25/24.
//

import Foundation

class ForumCellViewModel: ObservableObject {
    @Published var post: Post
    
    init(post: Post) {
        self.post = post
    }
    
    func like() async throws {
        post.didLike = true
        post.likes += 1
    }
    
    func unlike() async throws {
        post.didLike = false
        post.likes -= 1
    }
    
    func dislike() async throws {
        post.didDislike = true
        post.dislikes += 1
    }
    
    func undoDislike() async throws {
        post.didDislike = false
        post.dislikes -= 1
    }
    
    func bookmark() async throws {
        post.didBookmark = true
        post.favorites += 1
    }
    
    func unbookmark() async throws {
        post.didBookmark = false
        post.favorites -= 1
    }
}
