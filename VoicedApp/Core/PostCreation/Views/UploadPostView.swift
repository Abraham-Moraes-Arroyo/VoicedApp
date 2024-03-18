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
    @State private var imagePickerPresented = false
    @State private var photoItem: PhotosPickerItem?
    var body: some View {
        VStack {
            // action tool bar
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
                    print("upload")
                } label: {
                    Text("Upload")
                        .fontWeight(.semibold)
                }
            }
            .padding(.horizontal)
            
            // post image and title + caption
            HStack(spacing: 8){
                Image("default-post-image")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                VStack(spacing: 30){
                    
                    TextField("Enter your title...", text: $title, axis: .vertical)
                    
                    Divider()
                    
                    TextField("Enter your caption...", text: $caption)
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
