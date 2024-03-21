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
    @State private var selectedCategory: PostCategory = .miscellaneous // Default category
    @State private var imagePickerPresented = false
    @StateObject var viewModel = UploadPostViewModel()
    
    // when user clicks cancel this var will take user to a different tab index (in this case it will be the forum)
    @Binding var tabIndex: Int

    var body: some View {
        VStack {
            // Action tool bar
            HStack {
                Button {
                    // when you click cancel this happens/
                    title = ""
                   caption = ""
                    viewModel.selectedImage = nil
                    viewModel.postImage = nil
                    selectedCategory = .miscellaneous
                    tabIndex = 2
                    
                    
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
                if let image = viewModel.postImage {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipped()
                }
                
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
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
    }
}

#Preview {
    UploadPostView(tabIndex: .constant(2))
}
