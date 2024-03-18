//
//  UserContentListView.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 3/12/24.
//

import SwiftUI
struct UserContentListView: View {
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
        // Filter bar
        HStack {
            ForEach(ProfilePostFilter.allCases, id: \.self) { filter in
                VStack {
                    Text(filter.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == filter ? .semibold : .regular)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                selectedFilter = filter
                            }
                        }
                    
                    if selectedFilter == filter {
                        Rectangle()
                            .foregroundColor(.black)
                            .frame(width: filterBarWidth, height: 1)
                            .matchedGeometryEffect(id: "filterIndicator", in: animation)
                    }
                }
            }
        }
        .padding(.vertical)
        
        // Display posts based on the selected filter
        LazyVStack {
            ForEach(selectedFilter == .posts ? userPosts : allMockPosts) { post in
                ForumCell(post: post)
            }
        }
        
        
    }
}

#Preview {
    UserContentListView(user: User.MOCK_USERS[0])
}
