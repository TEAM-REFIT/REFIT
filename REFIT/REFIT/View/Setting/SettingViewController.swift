import UIKit

class SettingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func logoutBtn(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        
        let loginVC = getVC("LoginViewController")
        loginVC.modalPresentationStyle = .fullScreen
        loginVC.modalTransitionStyle = .crossDissolve
        present(loginVC, animated: true)
    }
}
