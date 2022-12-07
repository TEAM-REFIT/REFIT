import Foundation
import UIKit

extension UIViewController {
    func getVC(_ vc: String) -> UIViewController {
        let storyboard = UIStoryboard(name: vc, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: vc)
        return viewController
    }
    
    func initNavigationBar(title: String) {
        // navigation bar setting
        self.navigationItem.title = title
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.pretendard(size: 18, family: .SemiBold)]
    }
}

