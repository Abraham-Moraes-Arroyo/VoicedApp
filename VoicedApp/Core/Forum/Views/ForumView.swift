//
//  ForumView.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 3/12/24.
//

import SwiftUI

struct ForumView: View {
    @State private var isProfileViewActive = false
    @State private var sortingOption = "All"

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 35) {
                    // Use ForEach to dynamically create ForumCell views for each post
                    ForEach(Post.MOCK_POSTS, id: \.id) { post in
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
                        Button("All", action: { sortingOption = "All" })
                        Button("Reports", action: { sortingOption = "Reports" })
                        Button("Local News", action: { sortingOption = "Local News" })
                        Button("Events", action: { sortingOption = "Events" })
                        Button("Other", action: { sortingOption = "Other" })
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                }
            }
            .foregroundColor(.black)
            
            // Keep NavigationLink for later logic implementation
            // Make sure to adjust the destination view as per  future navigation model
//            NavigationLink(<#LocalizedStringKey#>, destination: ProfileView() {
//                EmptyView()
//            }
        }
    }
}
#Preview {
    ForumView()
}
