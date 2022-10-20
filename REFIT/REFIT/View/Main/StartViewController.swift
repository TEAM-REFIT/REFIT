import UIKit
import Firebase
import FirebaseAuth

class StartViewController: UIViewController {
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser == nil {
            // 로그인 상태가 아니면
            let loginVC = getVC("LoginViewController")
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: true)
        } else {
            // 로그인 상태면
            let mainNC = UIStoryboard(name: "MainClosetViewController", bundle: nil).instantiateViewController(withIdentifier: "MainClosetViewViewControllerNavigationController")
            mainNC.modalPresentationStyle = .fullScreen
            mainNC.modalTransitionStyle = .crossDissolve
            present(mainNC, animated: true)
        }
    }
}

