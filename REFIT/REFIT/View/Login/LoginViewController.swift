import Foundation
import UIKit

class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var googleLoginBtn: UIButton!
    
    // MARK: - Variables
    let viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - IBActions
    /// google log in
    @IBAction func googleLoginBtnTapped(_ sender: Any) {
        viewModel.googleLogin(self) {
            self.showMainViewController()
        }
    }

    // MARK: - Functions
    /// 메인화면 띄우기
    func showMainViewController() {
        let mainNC = UIStoryboard(name: "MainClosetViewController", bundle: nil).instantiateViewController(withIdentifier: "MainClosetViewViewControllerNavigationController")
        mainNC.modalPresentationStyle = .fullScreen
        mainNC.modalTransitionStyle = .crossDissolve
        present(mainNC, animated: true)
    }
}

