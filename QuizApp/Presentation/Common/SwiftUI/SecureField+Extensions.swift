import SwiftUI

extension SecureField {

    func isTextObuscated(_ value: Binding<Bool>, text: Binding<String>) -> some View {
        self.modifier(IsTextObuscated(isTextHidden: value, text: text))
    }

}
