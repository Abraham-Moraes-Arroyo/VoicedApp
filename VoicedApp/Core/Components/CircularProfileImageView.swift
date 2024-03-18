//
//  CircularProfileImageView.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 3/12/24.
//

import SwiftUI
// Example of directly using a mock user for preview
//let user: User = User.MOCK_USERS[0] // Assuming you want to use the first mock user
struct CircularProfileImageView: View {
    var body: some View {
        Image("image-marcial")
            .resizable()
            .scaledToFill()
            .frame(width: 50, height: 50)
            .clipShape(Circle())
    }
}

#Preview {
    CircularProfileImageView()
}
