import SwiftUI

struct BaseGradientView: ViewModifier {

    func body(content: Content) -> some View {
        ZStack {
            LinearGradient(
                colors: [.darkerPurple, .lightPurple],
                startPoint: .bottomLeading,
                endPoint: .topTrailing)
            .ignoresSafeArea()
            content
        }
    }

}

extension View {

    func brandStyleBackground() -> some View {
        modifier(BaseGradientView())
    }

}
