//
//  ClosetData.swift
//  REFIT
//
//  Created by 김동윤 on 2022/11/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase

class ClosetData {
    static let shared = ClosetData()
    
    //allCloset
    var allClosetData = [[String: Any]]()
    
    private init() {}
}

public struct Clothes: Codable {
    
    let userID: String
    let imageName: String
    
    let title: String
    let category: String
    let slider: Int
    let season: [String]
    let color: [String]
    let tpo: [String]
    let size: String
    let material: [String]

    enum CodingKeys: String, CodingKey {
        case userID = "userID"
        case imageName = "imageName"
        
        case title = "title"
        case category = "category"
        case slider = "slider"
        case season = "season"
        case color = "color"
        case tpo = "tpo"
        case size = "size"
        case material = "material"
    }
}

func getAllClosetData(completion: @escaping () -> Void) {
    FirebaseFirestoreManger.db.collection("Closet").whereField("userID", isEqualTo: FirebaseAuthManager.userID).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    ClosetData.shared.allClosetData.append(document.data())
                }
            }
        completion()
    }
}

func addClothesData(userID: String, imageName: String, title: String, category: String, slider: Int, season: [String], color: [String], tpo: [String], size: String, material: [String], completion: @escaping () -> Void) {
    // Firestore 데이터 구성
    let clothes = Clothes(userID: userID,
                          imageName: imageName,
                          title: title,
                          category: category,
                          slider: slider,
                          season: season,
                          color: color,
                          tpo: tpo,
                          size: size,
                          material: material)
    
    do {
        try FirebaseFirestoreManger.db.collection("Closet").document(imageName).setData(from: clothes)
    } catch let error {
        print("Error writing city to Firestore: \(error)")
    }
    completion()
}
