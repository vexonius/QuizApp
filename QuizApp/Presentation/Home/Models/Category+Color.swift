import SwiftUI

extension Category {

    var color: Color {
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
