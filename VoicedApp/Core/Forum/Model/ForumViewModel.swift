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
            // Directly using the specific URL when calling the method
                    let htmlContent = await fetchHTMLContent(from: "https://blockclubchicago.org/category/back-of-the-yards/")
                    await updatePostsFromHTML(htmlContent: htmlContent)
            
        }
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


extension ForumViewModel {
    func fetchHTMLContent(from url: String) async -> String {
        guard let url = URL(string: "https://blockclubchicago.org/category/back-of-the-yards/") else {
            print("Invalid URL")
            return ""
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let htmlContent = String(data: data, encoding: .utf8) {
                return htmlContent
            } else {
                print("Failed to decode HTML content")
                return ""
            }
        } catch {
            print("Error fetching HTML content: \(error)")
            return ""
        }
    }
}
