//
//  UIWindowExtension.swift
//  REFIT
//
//  Created by 김동윤 on 2023/03/30.
//

import Foundation
import UIKit

extension UIWindow {
    
    var visibleViewController: UIViewController? {
        return self.visibleViewControllerFrom(vc: self.rootViewController)
    }
    
    
//     # visibleViewControllerFrom
//     - Parameters:
//        - vc: rootViewController 혹은 UITapViewController
//     - Returns: UIViewController?
//     - Note: vc내에서 가장 최상위에 있는 뷰컨트롤러 반환
    
    func visibleViewControllerFrom(vc: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return self.visibleViewControllerFrom(vc: nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return self.visibleViewControllerFrom(vc: tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return self.visibleViewControllerFrom(vc: pvc)
            } else {
                return vc
            }
        }
    }
}
