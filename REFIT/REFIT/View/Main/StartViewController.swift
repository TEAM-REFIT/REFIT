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
            self.present(loginVC, animated: true, completion: nil)
            UIView.transition(with: self.view, duration: 1.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
        } else {
            // 로그인 상태면
            getAllClosetData {
                let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTapBarController")
                mainVC.modalPresentationStyle = .fullScreen
                mainVC.modalTransitionStyle = .crossDissolve
                self.present(mainVC, animated: true, completion: nil)
                UIView.transition(with: self.view, duration: 1.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
            }
        }
    }
}
