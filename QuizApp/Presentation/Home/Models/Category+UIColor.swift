import UIKit

extension Category {

    var uiColor: UIColor {
        switch self {
        case .sport:
            return .accentYellow
        case .movies:
            return .accentBlue
        default:
            return .white
        }
    }

}
