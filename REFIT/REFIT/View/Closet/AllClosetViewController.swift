import UIKit
import FirebaseCore
import FirebaseFirestore

class AllClosetViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func btn(_ sender: Any) {
        getClosetData()
    }
    
    @IBAction func btn2(_ sender: Any) {
        print(ClosetData.shared.allClosetData[0]["title"])
    }
}
