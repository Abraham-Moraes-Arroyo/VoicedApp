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
    @State private var sortingOption = "Miscellaneous"

    // This computed property filters the MOCK_POSTS to include only user-generated posts.
    var userGeneratedPosts: [Post] {
        viewModel.posts.filter { $0.isUserGenerated }
    }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 35) {
                    // Use ForEach to dynamically create ForumCell views for each filtered user-generated post
                    ForEach(userGeneratedPosts, id: \.id) { post in
                        ForumCell(post: post)
                            .onTapGesture {
                                // Placeholder for future implementation
                                // Will need to set a state variable here to determine which profile to show
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
                        // Placeholder action for profile view logic
                        isProfileViewActive = true
                    }) {
                        Image(systemName: "person")
                    }
                    
                    Button(action: {
                        // Logic to show trending or filtered posts
                        print("Trending posts selected")
                    }) {
                        Image(systemName: "flame")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("Miscellaneous", action: { sortingOption = "Miscellaneous" })
                        Button("Reports", action: { sortingOption = "Reports" })
                        Button("Happy Highlights", action: { sortingOption = "Happy Highlights" })
                        Button("Events", action: { sortingOption = "Events" })
                        Button("Business", action: { sortingOption = "Business" })
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                }
            }
            .foregroundColor(.black)
            
            // Keep NavigationLink for later logic implementation
            NavigationLink(destination: ProfileView(user: User.MOCK_USERS[0])) {
                EmptyView()
            }
        }
    }
}

#Preview {
    ForumView()
}
