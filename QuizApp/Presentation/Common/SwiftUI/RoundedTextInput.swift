import Combine
import SwiftUI

struct RoundedTextInput: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.sourceSansPro(size: DesignConstants.FontSize.regular.cgFloat, weight: .semibold))
            .foregroundColor(.white)
            .accentColor(.white)
            .padding(.vertical, 14)
            .padding(.horizontal, 24)
            .background(Color.white30)
            .cornerRadius(.infinity)
    }

}
