import Foundation
import UIKit

class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    @IBOutlet var LoginBtn: [UIButton]!
    
    // MARK: - Variables
    let viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        indicatorView.isHidden = true
        initLoginBtn()
    }

    // MARK: - IBActions
    /// google log in
    @IBAction func googleLoginBtnTapped(_ sender: Any) {
        viewModel.googleLogin(self) {
            self.showMainViewController()
        }
    }
    @IBAction func kakaoLoginBtnTapped(_ sender: Any) {
        print("hi")
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
        for i in LoginBtn {
            // title setting
            i.layer.cornerRadius = 25
        }
    }
}

