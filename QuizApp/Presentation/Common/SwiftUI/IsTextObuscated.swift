import SwiftUI

struct IsTextObuscated: ViewModifier {

    @Binding var isTextHidden: Bool
    @Binding var text: String
    @FocusState var fieldInFocus: SecureFieldType?

    private let secureFieldPadding: CGFloat = 1

    func body(content: Content) -> some View {
        ZStack {
            if isTextHidden {
                content
                    .padding(.vertical, secureFieldPadding)
                    .focused($fieldInFocus, equals: .secure)
            } else {
                TextField(LocalizedStrings.passwordPlaceholder.localizedString, text: $text)
                    .focused($fieldInFocus, equals: .plain)
            }
        }
        .onChange(of: isTextHidden) { newValue in
            fieldInFocus = isTextHidden ? .secure : .plain
        }
    }

}

enum SecureFieldType: Hashable {
    
    case plain
    case secure
    
}
