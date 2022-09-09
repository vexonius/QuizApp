import SwiftUI

extension Font {

    static func sourceSansPro(size: CGFloat, weight: SourceSansProWeight) -> Font {
        switch weight {
        case .regular:
            return Font.custom(SourceSansProWeight.regular.rawValue, size: size)
        case .semibold:
            return Font.custom(SourceSansProWeight.semibold.rawValue, size: size)
        case .bold:
            return Font.custom(SourceSansProWeight.bold.rawValue, size: size)
        }
    }

}
