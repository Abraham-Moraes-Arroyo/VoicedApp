//
//  VoicedTabView.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 3/12/24.
//

import SwiftUI
struct VoicedTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Map View")
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "map.fill" : "map")
                        .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                }
                .onAppear { selectedTab = 0 }
                .tag(0)
                    
            
            UploadPostView(tabIndex: $selectedTab)
                        .tabItem {
                            Image(systemName: "plus")
                        }
                        .onAppear { selectedTab = 1 }
                        .tag(1)
            
            
            //            ForumView(post: Post.MOCK_POSTS[0])
                        ForumView()
                                    .tabItem {
                                        Image(systemName: selectedTab == 2 ? "quote.bubble.fill" : "quote.bubble")
                                            .environment(\.symbolVariants, selectedTab == 2 ? .fill : .none)
                                    }
                                    .onAppear { selectedTab = 2 }
                                    .tag(2)
            
            
            HighlightsView()
                        .tabItem {
                            Image(systemName: selectedTab == 3 ? "face.smiling.inverse" : "face.smiling")
                                .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                        }
                        .onAppear { selectedTab = 3 }
                        .tag(3)
            
                    
                
        }
        .tint(Color.black)
    }
}


#Preview {
    VoicedTabView()
}
