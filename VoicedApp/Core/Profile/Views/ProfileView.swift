//
//  ProfileView.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 3/12/24.
//

import SwiftUI
struct ProfileView: View {
    let user: User
    @State private var selectedFilter: ProfilePostFilter = .posts
    @Namespace var animation
        
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfilePostFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 20
    }
    // Filtered posts by the user
    var userPosts: [Post] {
        Post.MOCK_POSTS.filter { $0.user?.id == user.id }
    }
    
    // All mock posts to simulate 'upvoted' or interacted posts
    var allMockPosts: [Post] {
        Post.MOCK_POSTS
    }
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 12) {
                // Header
                ProfileHeaderView(user: user)
                
                // user content list view
                UserContentListView(user: user)
            }
        }
        .padding(.horizontal)
        .navigationBarTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ProfileView(user: User.MOCK_USERS[0])
}
