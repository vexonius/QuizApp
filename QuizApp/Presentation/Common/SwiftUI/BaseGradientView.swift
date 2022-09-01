import SwiftUI

struct BaseGradientView: ViewModifier {

    func body(content: Content) -> some View {
        ZStack {
            content
            LinearGradient(
                colors: [.darkerPurple, .lightPurple],
                startPoint: .bottomLeading,
                endPoint: .topTrailing)
            .ignoresSafeArea()
        }
    }

}

extension View {

    func brandStyleBackground() -> some View {
        modifier(BaseGradientView())
    }

}
