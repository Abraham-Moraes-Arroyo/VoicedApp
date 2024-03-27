//
//  ForumViewModel.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 3/24/24.
//

import Foundation
import Firebase

// class responsible for fetching posts and displaying them
class ForumViewModel: ObservableObject {
    @Published var posts = [Post]()
    @Published var filteredPosts = [Post]()
        private var currentCategory: PostCategory = .miscellaneous
    // current category represents the default category
    
    init() {
        Task { try await fetchPosts() }
    }
    
    @MainActor
    func fetchPosts() async throws {
        self.posts = try await PostService.fetchForumPosts()
        
        applyCategoryFilter(category: currentCategory)
    }
    // Method to set the current category and filter posts accordingly
        func setCategory(_ category: PostCategory) {
            currentCategory = category
            applyCategoryFilter(category: category)
        }
        
        // Filter posts by the selected category
        private func applyCategoryFilter(category: PostCategory) {
            if category == .miscellaneous {
                // default category
                filteredPosts = posts
            } else {
                filteredPosts = posts.filter { $0.category == category }
            }
        }
    }
