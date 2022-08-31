import SwiftUI

struct RoundedButton: ViewModifier {

    private let verticalPadding: CGFloat = 14

    func body(content: Content) -> some View {
        content
            .padding(.vertical, verticalPadding)
            .background(.white)
            .clipShape(Capsule())
            .frame(maxWidth: .infinity)
    }

}
