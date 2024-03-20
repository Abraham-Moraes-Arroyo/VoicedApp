//
//  UploadPostViewModel.swift
//  VoicedApp
//
//  Created by Joanna Rodriguez on 3/19/24.
//

import Foundation
import SwiftUI
import PhotosUI

@MainActor
class UploadPostViewModel: ObservableObject {
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(fromItem: selectedImage) } }
    }
    
    @Published var postImage: Image?
    
//     this function is looking at the item from the photospicker item ->
//   creates data -> creates uiImage -> which generates the swiftUI image
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        
        guard let uiImage = UIImage(data: data) else { return }
        self.postImage = Image(uiImage: uiImage)
    }
}
