import SwiftUI

extension SecureField {

    func obfuscateText(_ text: Binding<String>, isTextObfuscated: Binding<Bool>) -> some View {
        self.modifier(TextObfuscationModifier( text: text, isTextObfuscated: isTextObfuscated))
    }

}
