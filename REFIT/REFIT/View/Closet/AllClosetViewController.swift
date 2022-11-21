import UIKit
import FirebaseCore
import FirebaseFirestore

class AllClosetViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func btn(_ sender: Any) {
        print("---")
        FirebaseFirestoreManger.db.collection("Closet").whereField("userID", isEqualTo: FirebaseAuthManager.userID).getDocuments() { (querySnapshot, err) in
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
