import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

final class LoginViewModel {
    var currentNonce: String?
    
    /// Indicator 보여주기
    func showIndicator(_ viewController: LoginViewController) {
        viewController.indicatorView.isHidden = false
        viewController.indicatorView.startAnimating()
    }

    /// Indicator 숨기기
    func hideIndicator(_ viewController: LoginViewController) {
        viewController.indicatorView.isHidden = true
        viewController.indicatorView.stopAnimating()
    }

    /// 구글 로그인
    func googleLogin(_ viewController: LoginViewController, completion: @escaping () -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let signInConfig = GIDConfiguration.init(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: viewController) { user, error in
            self.showIndicator(viewController)
            
            if let error = error {
                print("ERROR Google Sign In \(error.localizedDescription)")
                return
            }
            
            guard let authentication = user?.authentication else { return }
            let credential = GoogleAuthProvider.credential(
                withIDToken: authentication.idToken!,
                accessToken: authentication.accessToken
            )
            
            Auth.auth().signIn(with: credential) { _, _ in
                self.hideIndicator(viewController)
                completion()
            }
        }
    }

}
