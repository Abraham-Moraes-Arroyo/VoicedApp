//
//  PostReplyCell.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 4/4/24.
//

import SwiftUI

struct PostReplyCell: View {
    let reply: PostReply
    
    private var user: User? {
        return reply.replyUser
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let user = user {
                    CircularProfileImageView(user: user, size: .xSmall)
                    Text(user.username)
                        .fontWeight(.semibold)
                        .font(.footnote)
                    
                    Spacer() // This ensures everything is pushed to the left
                    
                    Text(reply.timestamp.timestampString())
                        .font(.caption)
                        .foregroundColor(Color(.systemGray3))
                    Button(action: {
                        // Action for button
                    }, label: {
                        Image(systemName: "ellipsis")
                            .foregroundStyle(Color(.darkGray))
                    })
                }
            }
            .padding(.horizontal)
            
            Divider()
            
            VStack(alignment: .leading) {
                Text(reply.replyText)
                    .font(.caption)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
            }
            .padding(.top, 1)
            .padding(.bottom, 1)
            

            
            Divider()
        }
    }
}



#Preview {
    PostReplyCell(reply: PostReply.MOCK_REPLIES[0])
}
