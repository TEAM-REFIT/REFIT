import UIKit

extension UIFont {
    
    enum Family {
        case Thin,
             ExtraLight,
             light,
             Regular,
             Medium,
             SemiBold,
             ExtraBold,
             Bold,
             Black
    }
    
    static func pretendard(size: CGFloat, family: Family) -> UIFont {
        return UIFont(name: "Pretendard-\(family)", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
