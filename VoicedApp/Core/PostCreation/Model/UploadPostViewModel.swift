//
//  UploadPostViewModel.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 3/19/24.
//

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
    private let defaultImage = Image("default-post-image") // Local default image
    private let defaultImageUrl = "https://firebasestorage.googleapis.com/v0/b/voiced-b1f36.appspot.com/o/profile_images%2Fdefault-post-image.jpg?alt=media&token=99f51562-b411-49b6-92ef-abbf00af15aa"

    init() {
        // Initialize with the default image
        self.postImage = defaultImage
    }
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item,
              let data = try? await item.loadTransferable(type: Data.self),
              let uiImage = UIImage(data: data) else {
            // If no image is selected or fails to load, revert to default image
            self.postImage = defaultImage
            return
        }
        
        self.uiImage = uiImage
        self.postImage = Image(uiImage: uiImage)
    }
    
    func uploadPost(title: String, caption: String = "", category: PostCategory) async throws {
        guard !title.isEmpty else {
            // Title is required
            throw UploadError.missingTitle
        }
        
        guard let uid = Auth.auth().currentUser?.uid else {
            throw UploadError.unauthorized
        }
        
        // Decide the imageUrl based on if a custom image was selected
        let imageUrl = uiImage != nil ? await uploadCustomImage() : defaultImageUrl
    
        
        // Create and upload the post
        let post = Post(
            id: UUID().uuidString,
            ownerUid: uid,
            title: title,
            caption: caption,
            likes: 0,
            dislikes: 0,
            imageUrl: imageUrl,
            timestamp: Timestamp(),
            category: category
        )
        
        guard let encodedPost = try? Firestore.Encoder().encode(post) else { return }
        let postRef = Firestore.firestore().collection("posts").document(post.id)
        try await postRef.setData(encodedPost)
    }
    
    private func uploadCustomImage() async -> String {
        // existing image uploading logic, returning the URL of the uploaded image
        return "default-post-image"
    }
    
    enum UploadError: Error {
        case missingTitle, unauthorized, encodingFailed
    }
}
