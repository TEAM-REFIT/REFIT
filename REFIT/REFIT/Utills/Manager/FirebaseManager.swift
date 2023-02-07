//
//  FirebaseManager.swift
//  REFIT
//
//  Created by 김동윤 on 2022/11/11.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import UIKit

// Auth
class FirebaseAuthManager {
    static let auth = Auth.auth()
    static let userID = Auth.auth().currentUser!.uid
    static let userName = Auth.auth().currentUser!.displayName
    static let userProfileImg = Auth.auth().currentUser!.photoURL
}

// Data base
class FirebaseFirestoreManger {
    static let db = Firestore.firestore()
}

// image storage
class FirebaseStorageManager {
    static func uploadImage(name: String,image: UIImage, completion: @escaping (URL?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.4) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        let firebaseReference = Storage.storage().reference().child("\(name)")
        firebaseReference.putData(imageData, metadata: metaData) { metaData, error in
            firebaseReference.downloadURL { url, _ in
                completion(url)
            }
        }
    }
    
    static func downloadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        let storageReference = Storage.storage().reference(forURL: urlString)
        let megaByte = Int64(1 * 1024 * 1024)
        
        storageReference.getData(maxSize: megaByte) { data, error in
            guard let imageData = data else {
                completion(nil)
                return
            }
            completion(UIImage(data: imageData))
        }
    }
}
