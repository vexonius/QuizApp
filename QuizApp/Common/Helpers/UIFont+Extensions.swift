import Foundation
import UIKit

enum SourceSansProWeight: String {

    case regular = "SourceSansPro-Regular"
    case semibold = "SourceSansPro-SemiBold"
    case bold = "SourceSansPro-Bold"

}

extension UIFont {

    static func sourceSansPro(ofSize size: CGFloat, ofWeight weight: SourceSansProWeight = .regular) -> UIFont! {
        switch weight {
        case .regular:
            return UIFont(name: weight.rawValue, size: size)
        case .semibold:
            return UIFont(name: weight.rawValue, size: size)
        case .bold:
            return UIFont(name: weight.rawValue, size: size)
        }
    }

}
