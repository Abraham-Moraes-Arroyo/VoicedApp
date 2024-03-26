//
//  UploadPostViewModel.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 3/19/24.
//

import Foundation
import SwiftUI
import PhotosUI
import Firebase

@MainActor
class UploadPostViewModel: ObservableObject {
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(fromItem: selectedImage) } }
    }
    
    @Published var postImage: Image?
    private var uiImage: UIImage?
    
//     this function is looking at the item from the photospicker item ->
//   creates data -> creates uiImage -> which generates the swiftUI image
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.postImage = Image(uiImage: uiImage)
    }
    
    func uploadPost(title: String, caption: String, category: PostCategory) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let uiImage = uiImage else { return }
        
        // create post collection:
        let postRef = Firestore.firestore().collection("posts").document()
        
        guard let imageUrl = try await ImageUploader.uploadImage(image: uiImage) else { return }

        let post = Post(id: postRef.documentID, ownerUid: uid, title: title, caption: caption, likes: 0, dislikes: 0, favorites: 0, comments: 0, imageUrl: imageUrl, timestamp: Timestamp(), category: PostCategory(rawValue: category.rawValue) ?? PostCategory.miscellaneous)
        
        guard let encodedPost = try? Firestore.Encoder().encode(post) else { return }
        // upload post to firestore
        try await postRef.setData(encodedPost)
    }
}
