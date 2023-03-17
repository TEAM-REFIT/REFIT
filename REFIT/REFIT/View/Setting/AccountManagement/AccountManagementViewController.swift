//
//  AccountManagementViewController.swift
//  REFIT
//
//  Created by 김동윤 on 2023/03/17.
//

import Foundation
import UIKit

class AccountManagementViewController: UIViewController {
    @IBOutlet var btns: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        initBtnDesign()
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
