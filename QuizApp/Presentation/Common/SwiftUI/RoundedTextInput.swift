import Combine
import SwiftUI

struct RoundedTextInput: ViewModifier {

    private let verticalPadding: CGFloat = 14
    private let horizontalPadding: CGFloat = 24

    func body(content: Content) -> some View {
        content
            .font(.sourceSansPro(size: DesignConstants.FontSize.regular.cgFloat, weight: .semibold))
            .foregroundColor(.white)
            .accentColor(.white)
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
            .background(.white.opacity(0.3))
            .cornerRadius(.infinity)
    }

}
