import UIKit

//pretendard
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
    
    ///Pretendard
    static func pretendard(size: CGFloat, family: Family) -> UIFont {
        return UIFont(name: "Pretendard-\(family)", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    ///Roboto
    static func Roboto(size: CGFloat, family: Family) -> UIFont {
        return UIFont(name: "Roboto-\(family)", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
