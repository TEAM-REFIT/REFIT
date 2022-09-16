//
//  SecondViewController.swift
//  REFIT
//
//  Created by 김동윤 on 2022/09/15.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class SecondViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var sizeTextField: UILabel!
    @IBOutlet weak var colorTextField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func btn(_ sender: Any) {
        let db = Firestore.firestore()
        var id = ""
        // Add a new document with a generated id.
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "name": nameTextField.text ?? "유저",
            "age": sizeTextField.text ?? "00",
            "color":colorTextField.text ?? "색깔"
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                id = ref!.documentID
                print(id)
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        let docRef = db.collection("users").document(id)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
    }
}

