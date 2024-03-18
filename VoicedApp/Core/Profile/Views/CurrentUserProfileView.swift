//
//  CurrentUserProfileView.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 3/12/24.
//

import SwiftUI
struct CurrentUserProfileView: View {
    
    let user: User
    
    @State private var selectedFilter: ProfilePostFilter = .posts
    @Namespace var animation
    
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfilePostFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 20
    }
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 12) {
                    // header
                    ProfileHeaderView(user: user)
                    
                    // user content list view
                    UserContentListView(user: user)
                        
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    CurrentUserProfileView(user: User.MOCK_USERS[0])
}
