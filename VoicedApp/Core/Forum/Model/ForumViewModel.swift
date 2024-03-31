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
        Task { try await fetchPosts()
            let htmlContent = await fetchHTMLContent()
                        await updatePostsFromHTML(htmlContent: htmlContent)
            
        }
    }
    
    // Dummy method representing asynchronous HTML content fetching
    func fetchHTMLContent() async -> String {
        // Fetch or generate your HTML content here
        return "<html>...</html>"
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

extension ForumViewModel {
    @MainActor
    func updatePostsFromHTML(htmlContent: String) {
        let parser = HTMLParser()
        let newPosts = parser.parse(html: htmlContent)
        
        // Assuming newPosts are meant to replace or be added to existing posts
        DispatchQueue.main.async {
            self.posts.append(contentsOf: newPosts)
            self.applyCategoryFilter(category: self.currentCategory)
        }
    }
}

