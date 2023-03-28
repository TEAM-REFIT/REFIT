//
//  AccountManagementViewController.swift
//  REFIT
//
//  Created by 김동윤 on 2023/03/17.
//

import Foundation
import UIKit

import FirebaseAuth

class AccountManagementViewController: UIViewController {
    
    @IBOutlet var btns: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        initBtnDesign()
    }
    
    @IBAction func logoutBtnTapped(_ sender: Any) {
        let alert = UIAlertController(title: "로그아웃하시겠습니까?", message: "", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let delete = UIAlertAction(title: "로그아웃", style: .destructive) {_ in
            do {
                try FirebaseAuthManager.auth.signOut()
                let loginVC = self.getVC("LoginViewController")
                loginVC.modalPresentationStyle = .fullScreen
                loginVC.modalTransitionStyle = .crossDissolve
                
                // ClosetData 데이터 삭제
                ClosetData.shared.allClosetData.removeAll()
                ClosetData.shared.topClosetData.removeAll()
                ClosetData.shared.pantsClosetData.removeAll()
                ClosetData.shared.outerClosetData.removeAll()
                ClosetData.shared.shoesClosetData.removeAll()
                ClosetData.shared.etcClosetData.removeAll()
                
                UserDefaults.standard.set("logout", forKey: "loginInfo")
                self.present(loginVC, animated: true)
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
        }
        
        alert.addAction(delete)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func removeAccountBtnTapped(_ sender: Any) {
        let alert = UIAlertController(title: "계정을 삭제하시겠습니까?", message: "계정 삭제 시 옷장에 등록된 옷은\n모두 삭제되며, 복구할 수 없습니다.", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "취소", style: .default)
        let delete = UIAlertAction(title: "삭제하기", style: .destructive) { action in
            let user = Auth.auth().currentUser
            user?.delete { error in
                if error != nil {
                    // An error happened.
                    print(error)
                } else {
                    // Account deleted.
                    print("delete")
                    let loginVC = self.getVC("LoginViewController")
                    loginVC.modalPresentationStyle = .fullScreen
                    loginVC.modalTransitionStyle = .crossDissolve
                    self.present(loginVC, animated: true)
                }
            }
            
        }
        
        alert.addAction(delete)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension AccountManagementViewController {
    private func initNavigationBar() {
        self.navigationItem.title = "옷 등록"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.pretendard(size: 18, family: .SemiBold)]
    }
    
    private func initBtnDesign() {
        for i in btns {
            i.layer.cornerRadius = 10
        }
    }
}
