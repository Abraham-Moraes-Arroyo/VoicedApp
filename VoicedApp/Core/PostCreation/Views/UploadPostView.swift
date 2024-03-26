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
    @State private var selectedCategory: PostCategory = .miscellaneous
    @State private var imagePickerPresented = false
    @StateObject var viewModel = UploadPostViewModel()
    
    @Binding var tabIndex: Int
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            HStack {
                Button("Cancel") {
                    clearPostDataAndReturnToForum()
                }
                Spacer()
                Text("What's going on?")
                    .fontWeight(.semibold)
                Spacer()
                Button("Upload") {
                    print("Uploading Post...")
                       print("Title: \(title)")
                       print("Caption: \(caption)")
                       print("Category: \(selectedCategory.rawValue)")
                       
                    Task {
                        try await viewModel.uploadPost(title: title, caption: caption, category: selectedCategory)
                        clearPostDataAndReturnToForum()
                    }
                }
                .fontWeight(.semibold)
                .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            .padding(.horizontal)
            
            VStack(spacing: 8) {
                Button(action: {
                    // This ensures the picker is only presented when the user presses the button
                    imagePickerPresented = true
                }) {
                    if let image = viewModel.postImage {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .foregroundColor(.gray)
                    }
                }
                .buttonStyle(.plain)
                .sheet(isPresented: $imagePickerPresented) {
                    PhotosPicker(selection: $viewModel.selectedImage, matching: .images, photoLibrary: .shared()) {
                        Text("Select a Photo")
                        
                    }
                }

                TextField("Enter your title...", text: $title)
                    .textFieldStyle(.roundedBorder)
                    
                
                TextField("Enter your caption...", text: $caption)
                    .textFieldStyle(.roundedBorder)
                HStack {
                    Text("Choose a category: ")
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(PostCategory.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
            }
            .padding()
            
            Spacer()
        }
    }
    
    func clearPostDataAndReturnToForum() {
        title = ""
        caption = ""
        // Reset the image picker state as well to prevent automatic re-presentation
        imagePickerPresented = false
        viewModel.selectedImage = nil
        viewModel.postImage = nil
        selectedCategory = .miscellaneous
        tabIndex = 2
        dismiss()
    }
}


#Preview {
    UploadPostView(tabIndex: .constant(2))
}
