import UIKit

class AddClosetViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
    }
    
    func initNavigationBar() {
        //remove navigation bar item title
        self.navigationController?.navigationBar.topItem?.title = ""
    }
}
