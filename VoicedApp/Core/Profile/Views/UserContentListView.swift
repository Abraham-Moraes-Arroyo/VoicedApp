//
//  UserContentListView.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 3/12/24.
//

import SwiftUI

struct UserContentListView: View {
    @State private var selectedFilter: ProfilePostFilter = .posts
    @Namespace var animation
    
    @StateObject var viewModel: ProfileViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: ProfileViewModel(user: user))
    }
    
    var body: some View {
        VStack {
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
                                    fetchData(for: filter)
                                }
                            }
                        
                        if selectedFilter == filter {
                            Rectangle()
                                .foregroundColor(.black)
                                .frame(height: 2)
                                .matchedGeometryEffect(id: "filterIndicator", in: animation)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
            
            // Display posts based on the selected filter
            ScrollView {
                LazyVStack {
                    ForEach(currentPosts, id: \.id) { post in
                        ForumCell(post: post)
                    }
                }
            }
        }
        .onAppear {
            fetchData(for: selectedFilter)
        }
    }
    
    // Determine which posts to show based on the selected filter
    private var currentPosts: [Post] {
        switch selectedFilter {
        case .posts:
            return viewModel.posts
        case .upvoted_posts:
            return viewModel.likedPosts
        case .bookmarks:
            print("Switched to bookmarks filter")
            return viewModel.bookmarkedPosts
        }
    }
    
    private func fetchData(for filter: ProfilePostFilter) {
        switch filter {
        case .posts:
            Task { try await viewModel.fetchUserPosts() }
        case .upvoted_posts:
            Task { try await viewModel.fetchLikedPosts() }
        case .bookmarks:
            Task { try await viewModel.fetchBookmarkedPosts() }
        }
    }
}


#Preview {
    UserContentListView(user: User.MOCK_USERS[0])
}
