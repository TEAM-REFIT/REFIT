import Foundation
import UIKit

class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var LoginBtn: [UIButton]!
    
    // MARK: - Variables
    let viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        initLoginBtn()
    }

    // MARK: - IBActions
    /// google log in
    @IBAction func googleLoginBtnTapped(_ sender: Any) {
        viewModel.googleLogin(self) {
            self.showMainViewController()
        }
    }

    // MARK: - Functions
    /// show main closet view
    func showMainViewController() {
        let mainNC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTapBarController")
        mainNC.modalPresentationStyle = .fullScreen
        mainNC.modalTransitionStyle = .crossDissolve
        present(mainNC, animated: true)
    }
    
    //MARK: - init
    /// init LoginBtn
    func initLoginBtn() {
//        let loginBtntitleArr = ["Google 로 로그인", "카카오 로 로그인", "apple ID 로 로그인"]
        for i in LoginBtn {
            // title setting
            i.layer.cornerRadius = 25
            // font setting
        }
    }
}

