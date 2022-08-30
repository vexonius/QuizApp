import UIKit
import SwiftUI

extension Category {

    var color: UIColor {
        switch self {
        case .sport:
            return .accentYellow
        case .movies:
            return .accentBlue
        default:
            return .white
        }
    }

    var colour: Color {
        switch self {
        case .sport:
            return .accentYellow
        case .movies:
            return .accentBlue
        default:
            return .white
        }
    }

    var named: String {
        switch self {
        case .uncategorized:
            return LocalizedStrings.all.localizedString
        default:
            return self.rawValue
        }
    }

}
