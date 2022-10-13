import SwiftUI

struct TextObfuscationModifier: ViewModifier {

    @Binding var text: String
    @Binding var isTextObfuscated: Bool
    @FocusState var fieldInFocus: SecureFieldType?

    private let secureFieldPadding: CGFloat = 1

    func body(content: Content) -> some View {
        ZStack {
            if isTextObfuscated {
                content
                    .padding(.vertical, secureFieldPadding)
                    .focused($fieldInFocus, equals: .secure)
            } else {
                TextField(LocalizedStrings.passwordPlaceholder.localizedString, text: $text)
                    .focused($fieldInFocus, equals: .plain)
            }
        }
        .onChange(of: isTextObfuscated) { isHidden in
            fieldInFocus = isHidden ? .secure : .plain
        }
    }

}

enum SecureFieldType: Hashable {

    case plain
    case secure

}
