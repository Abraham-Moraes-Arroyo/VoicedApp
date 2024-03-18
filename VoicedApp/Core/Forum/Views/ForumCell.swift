//
//  ForumCell.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 3/12/24.
//



import SwiftUI
struct ForumCell: View {
    let post: Post
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1
    @State private var showingActionSheet = false
    var body: some View {
        VStack {
            HStack {
                if let user = post.user {
                    Image(user.profileImageUrl ?? "")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    Text(user.username)
                        .fontWeight(.semibold)
                }
                Spacer()
                // Post verification status
                if post.isUserGenerated {
                    Label("User Generated", systemImage: "person.fill")
//                        .labelStyle(.iconOnly)
                        .padding(5)
                        .background(Color.blue.opacity(0.1)) // Semi-transparent background
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .foregroundColor(.blue)
                        .padding(.trailing, 10)
                } else {
                    Label("Verified", systemImage: "checkmark.seal.fill")
//                        .labelStyle(.iconOnly)
                        .padding(5)
                        .background(Color.green.opacity(0.1)) // Semi-transparent background
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundColor(.green)
                        .padding(.trailing, 10)
                }
            }
            .padding(.leading)
            Divider()
            VStack {
                HStack(spacing: 26){
                    Image(post.imageUrl ?? "default-post-image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Rectangle())
                    
                    VStack(spacing: 8) {
                        Text(post.title)
                            .fontWeight(.semibold)
                            .font(.title)
                            .multilineTextAlignment(.center)
                        
                        Text(post.caption ?? "")
                            .multilineTextAlignment(.center)
                        
                        Text(post.category.displayName)
                            .padding()
                            .foregroundColor(.white)
                            .background(post.category.color)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding()
                    }
                }
                .padding(.leading)
                actionButtons
            }
            .padding(.bottom, 8)
            
            Divider()
        }
    }
    @ViewBuilder
    var actionButtons: some View {
        HStack (spacing: 25) {
            Spacer()
            Button(action: { print("Upvote Post") }) {
                HStack {
                    Image(systemName: "hand.thumbsup")
                    Text("\(post.likes)")
                }
            }
            
            Button(action: { print("Downvote Post") }) {
                HStack {
                    Image(systemName: "hand.thumbsdown")
                    Text("\(post.dislikes)")
                }
            }
            
            Button(action: { print("Comment Post") }) {
                HStack {
                    Image(systemName: "bubble.right")
                    Text("1") // Ideally, this should reflect the actual number of comments
                }
            }
            
            Button(action: { showingActionSheet = true }) {
                Image(systemName: "ellipsis")
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text("Options"), message: Text("Choose an option"), buttons: [
                    .default(Text("Report")) { print("Flag selected") },
                    .default(Text("Bookmark")) { print("Bookmark selected") },
                    .cancel()
                ])
            }
            Spacer()
        }
        .padding(.top, 4)
        .foregroundColor(.black)
    }
}

#Preview {
    ForumCell(post: Post.MOCK_POSTS[3])
}
