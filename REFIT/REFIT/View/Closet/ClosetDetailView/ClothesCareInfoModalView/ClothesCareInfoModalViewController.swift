//
//  ClothesCareInfoModalViewController.swift
//  REFIT
//
//  Created by 김동윤 on 2022/12/20.
//

import Foundation
import UIKit

class ClothesCareInfoModalViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setNeedsLayout() 
        
        initNavigationBar(title: "디테일")
    }
}
