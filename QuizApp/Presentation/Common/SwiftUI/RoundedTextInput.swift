import Combine
import SwiftUI

struct RoundedTextInput: ViewModifier {

    private let verticalPadding: CGFloat = 14
    private let horizontalPadding: CGFloat = 24
    private let strokeWidth: CGFloat = 1.2

    @FocusState var focused: Bool

    func body(content: Content) -> some View {
        content
            .font(.sourceSansPro(size: DesignConstants.FontSize.regular.cgFloat, weight: .semibold))
            .foregroundColor(.white)
            .accentColor(.white)
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
            .background(Color.white30)
            .cornerRadius(.infinity)
            .focused($focused, equals: true)
            .overlay {
                if focused {
                    Capsule(style: .continuous)
                        .stroke(.white, style: StrokeStyle(lineWidth: strokeWidth))
                }
            }
    }

}
