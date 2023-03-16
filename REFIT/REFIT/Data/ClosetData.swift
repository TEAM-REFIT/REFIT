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

struct ClosetData {
    static var shared = ClosetData()
    
    //allCloset
    var allClosetData = [[String: Any]]()
    var topClosetData = [[String: Any]]()
    var pantsClosetData = [[String: Any]]()
    var outerClosetData = [[String: Any]]()
    var shoesClosetData = [[String: Any]]()
    var etcClosetData = [[String: Any]]()
    
    private init() {}
}

public struct Clothes: Codable {
    
    let userID: String
    let imageUrl: String
    
    let documentName: String
    let title: String
    let category: String
    let detailCategory: String
    let slider: Int
    let season: [String]
    let color: [String]
    let tpo: [String]
    let size: String
    let brand: String
    let material: [String]
    let timeStamp: Timestamp

    enum CodingKeys: String, CodingKey {
        case userID
        case imageUrl
        
        case documentName
        case title
        case category
        case detailCategory
        case slider
        case season
        case color
        case tpo
        case size
        case brand
        case material
        case timeStamp
    }
}

func getAllClosetData(completion: @escaping () -> Void) {
    FirebaseAuthManager.userID = Auth.auth().currentUser!.uid
    
    FirebaseFirestoreManger.db
        .collection("Closet")
        .whereField("userID", isEqualTo: FirebaseAuthManager.userID)
        .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let category = document.data()["category"] as! String
                    switch category {
                    case "상의":
                        ClosetData.shared.topClosetData.append(document.data())
                    case "하의":
                        ClosetData.shared.pantsClosetData.append(document.data())
                        
                    case "아우터":
                        ClosetData.shared.outerClosetData.append(document.data())
                        
                    case "신발":
                        ClosetData.shared.shoesClosetData.append(document.data())
                        
                    case "기타":
                        ClosetData.shared.etcClosetData.append(document.data())
                    default:
                        break
                    }
                    ClosetData.shared.allClosetData.append(document.data())
                }
            }
        completion()
    }
}

func addClothesData(clothesName: String, userID: String, imageUrl: String, title: String, category: String, detailCategory: String, slider: Int, season: [String], color: [String], tpo: [String], size: String, brand: String, material: [String]) {
    // Firestore 데이터 구성
    let clothes = Clothes(userID: userID,
                          imageUrl: imageUrl,
                          documentName: clothesName,
                          title: title,
                          category: category,
                          detailCategory: detailCategory,
                          slider: slider,
                          season: season,
                          color: color,
                          tpo: tpo,
                          size: size,
                          brand: brand,
                          material: material,
                          timeStamp: Timestamp(date: Date()))
    
    do {
        try FirebaseFirestoreManger.db.collection("Closet").document("\(clothesName)").setData(from: clothes)
    } catch let error {
        print("Error writing city to Firestore: \(error)")
    }
}
