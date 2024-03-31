//
//  ForumView.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 3/12/24.
//

import SwiftUI

struct ForumView: View {
    @StateObject var viewModel = ForumViewModel()
    @State private var isProfileViewActive = false
    @State private var selectedCategory: PostCategory = .miscellaneous // Updated to use PostCategory enum

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 35) {
                    // Dynamically create ForumCell views for each post in filteredPosts
                    ForEach(viewModel.filteredPosts, id: \.id) { post in
                        ForumCell(post: post)
                            .onTapGesture {
                                // Placeholder for future implementation
                                isProfileViewActive = true
                            }
                    }
                }
            }
            .navigationTitle("Forum")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    
                    Button(action: {
                        // Logic to show trending or filtered posts
                        print("Trending posts selected")
                    }) {
                        Image(systemName: "flame")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        ForEach(PostCategory.allCases, id: \.self) { category in
                            Button(category.displayName, action: {
                                selectedCategory = category
                                viewModel.setCategory(category)
                            })
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                }
            }
            .foregroundColor(.black)
        }
        .onChange(of: selectedCategory) { newValue in
            viewModel.setCategory(newValue)
        }
    }
    
    
}

#Preview {
    ForumView()
}
