import Foundation
import UIKit
import AuthenticationServices
import CryptoKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {
    // MARK: - Variables
    let viewModel = LoginViewModel()
    
    // MARK: - Properties
    fileprivate var currentNonce: String?
    
    // MARK: - IBOutlets
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    @IBOutlet var LoginBtn: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        indicatorView.isHidden = true
        initLoginBtn()
    }

    // MARK: - IBActions
    /// google log in
    @IBAction func googleLoginBtnTapped(_ sender: Any) {
        viewModel.googleLogin(self) {
            getAllClosetData {
                self.showMainViewController()
            }
        }
    }
    
    @IBAction func appleLoginBtnTapped(_ sender: Any) {
        let request = createAppleIDRequest()
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        
        viewModel.showIndicator(self)
    }
    
    
    // MARK: - Functions
    /// show main closet view
    func showMainViewController() {
        let mainNC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTapBarController")
        mainNC.modalPresentationStyle = .fullScreen
        mainNC.modalTransitionStyle = .crossDissolve
        present(mainNC, animated: true)
    }
    
    @available(iOS 13, *)
    func createAppleIDRequest() -> ASAuthorizationAppleIDRequest {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        // 애플로그인은 사용자에게서 2가지 정보를 요구
        request.requestedScopes = [.fullName, .email]

        let nonce = randomNonceString()
        request.nonce = sha256(nonce)
        currentNonce = nonce
        
        return request
    }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
        }.joined()

          return hashString
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

// MARK: - ASAuthorizationControllerPresentationContextProviding
extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

// MARK: - ASAuthorizationControllerDelegate
@available(iOS 13.0, *)
extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // 몇 가지 표준 키 검사를 수행
            // 1️⃣ 현재 nonce가 설정되어 있는지 확인
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            
            // 2️⃣ ID 토큰을 검색하여
            guard let appleIDtoken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            
            // 3️⃣ 문자열로 변환
            guard let idTokenString = String(data: appleIDtoken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDtoken.debugDescription)")
                return
            }
            
            // 4️⃣
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            
            // 5️⃣
            FirebaseAuthManager.auth.signIn(with: credential) { [self] (authDataResult, error) in
                // 인증 결과에서 Firebase 사용자를 검색하고 사용자 정보를 표시할 수 있다.
                if let user = authDataResult?.user {
                    print("애플 로그인 성공", user.uid, user.email ?? "-")
                    getAllClosetData {
                        self.showMainViewController()
                    }
                }
                
                if error != nil {
                    print(error?.localizedDescription ?? "error" as Any)
                    return
                }
            }
        }
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
            // Handle error.
            viewModel.hideIndicator(self)
            print("Sign in with Apple errored: \(error)")
    }
}

private func randomNonceString(length: Int = 32) -> String {
  precondition(length > 0)
  let charset: Array<Character> =
      Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
  var result = ""
  var remainingLength = length

  while remainingLength > 0 {
    let randoms: [UInt8] = (0 ..< 16).map { _ in
      var random: UInt8 = 0
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
      if errorCode != errSecSuccess {
        fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
      }
      return random
    }

    randoms.forEach { random in
      if remainingLength == 0 {
        return
      }

      if random < charset.count {
        result.append(charset[Int(random)])
        remainingLength -= 1
      }
    }
  }

  return result
}

