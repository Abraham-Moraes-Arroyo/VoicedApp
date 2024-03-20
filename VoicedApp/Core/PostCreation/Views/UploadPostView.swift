//
//  UploadPostView.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 3/12/24.
//

import SwiftUI
import PhotosUI

struct UploadPostView: View {
    @State private var title = ""
    @State private var caption = ""
    @State private var selectedCategory: PostCategory = .businesses // Default category
    @State private var imagePickerPresented = false
    @State private var photoItem: PhotosPickerItem?

    var body: some View {
        VStack {
            // Action tool bar
            HStack {
                Button {
                    print("Cancel upload")
                } label: {
                    Text("Cancel")
                }
                Spacer()
                
                Text("What's going on?")
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    print("Upload")
                } label: {
                    Text("Upload")
                        .fontWeight(.semibold)
                }
            }
            .padding(.horizontal)
            
            // Post image, title, caption, and category selection
            VStack(spacing: 8){
                Image("default-post-image")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                TextField("Enter your title...", text: $title, axis: .vertical)
                
                Divider()
                
                TextField("Enter your caption...", text: $caption)
                
                Divider()
                
                HStack {
                    Text("Choose a category: ")
                    // Category Picker
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(PostCategory.allCases, id: \.self) { category in
                            Text(category.rawValue)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
            }
            .padding()
            
            Spacer()
        }
        .onAppear {
            imagePickerPresented.toggle()
        }
        .photosPicker(isPresented: $imagePickerPresented, selection: $photoItem)
    }
}

#Preview {
    UploadPostView()
}
