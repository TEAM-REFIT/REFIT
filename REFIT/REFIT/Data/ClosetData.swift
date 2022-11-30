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
    let timeStamp: Timestamp

    enum CodingKeys: String, CodingKey {
        case userID
        case imageName
        
        case title
        case category
        case slider
        case season
        case color
        case tpo
        case size
        case material
        case timeStamp
    }
}

func getAllClosetData(completion: @escaping () -> Void) {
    FirebaseFirestoreManger.db
        .collection("Closet")
        .whereField("userID", isEqualTo: FirebaseAuthManager.userID)
        .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    ClosetData.shared.allClosetData.append(document.data())
                    print(document.data()["timeStamp"]!)
                }
            }
//            ClosetData.shared.allClosetData.sort{
//                ($0["timeStamp"] as? Timestamp)! < ($1["timeStamp"] as? Timestamp)!
//            }
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
                          material: material,
                          timeStamp: Timestamp(date: Date()))
    
    do {
        try FirebaseFirestoreManger.db.collection("Closet").document(imageName).setData(from: clothes)
    } catch let error {
        print("Error writing city to Firestore: \(error)")
    }
    completion()
}
