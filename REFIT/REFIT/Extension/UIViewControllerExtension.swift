import Foundation
import UIKit

extension UIViewController {
    func getVC(_ vc: String) -> UIViewController {
        let storyboard = UIStoryboard(name: vc, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: vc)
        return viewController
    }
}

