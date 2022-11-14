import UIKit
import FirebaseCore
import FirebaseFirestore

class AllClosetViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btn(_ sender: Any) {
        FirebaseFirestoreManger.db.collection("Closet-\(FirebaseAuthManager.userID)").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
}
