import SwiftUI

struct RoundedButton: ViewModifier {

    func body(content: Content) -> some View {
        content
            .padding(.vertical, 14)
            .background(.white)
            .clipShape(Capsule())
            .frame(maxWidth: .infinity)
    }

}
