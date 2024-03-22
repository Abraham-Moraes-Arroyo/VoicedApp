//
//  ProfileHeaderView.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 3/12/24.
//

import SwiftUI
struct ProfileHeaderView: View {
    let user: User
    var body: some View {
        VStack(spacing: 12) {
            // Header
            VStack(alignment: .leading) {
                HStack {
                    Image(user.profileImageUrl ?? "profile_default")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text(user.username)
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text(user.bio ?? "")
                            .font(.footnote)
                    }
                    .frame(width: 130, alignment: .leading)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                if user.isCurrentUser {
                    Button {
                        if user.isCurrentUser {
                            print("Show edit profile")
                        }
                    } label : {
                     Text("Edit Profile")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, minHeight: 32)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    }
                    
                    .padding(.horizontal)
                    
                }
                
                
                Divider()
            }
        }
    }
}

#Preview {
    ProfileHeaderView(user: User.MOCK_USERS[0])
}
