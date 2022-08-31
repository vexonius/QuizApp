import SwiftUI
import Resolver

struct LoginView: View {

    @ObservedObject var viewModel: LoginViewModel

    @State var username: String = ""
    @State var password: String = ""

    @FocusState var passwordInFocus: SecureFieldType?

    var body: some View {
        VStack (spacing: DesignConstants.Insets.componentSpacing.cgFloat) {
            Spacer()
            Text(LocalizedStrings.appName.localizedString)
                .font(.system(size: DesignConstants.FontSize.heading.cgFloat, weight: .bold, design: .default))
                .foregroundColor(.white)
            Spacer()
            TextField(
                LocalizedStrings.usernamePlaceholder.localizedString,
                text: $username)
                .modifier(RoundedTextInput())
                .padding(.horizontal, DesignConstants.Insets.componentsInset.cgFloat)
                .onChange(of: username) { newValue in
                    viewModel.onEmailChanged(newValue)
                }
            ZStack(alignment: .trailing) {
                if viewModel.isPasswordHidden {
                    SecureField(LocalizedStrings.passwordPlaceholder.localizedString, text: $password)
                        .padding(.vertical, 1) // Secure field seems a tiny bit smaller, therefore you can see a glitch
                        .focused($passwordInFocus, equals: .secure)
                        .modifier(RoundedTextInput())
                        .onChange(of: password) { newValue in
                            viewModel.onPasswordChanged(newValue)
                        }
                } else {
                    TextField(LocalizedStrings.passwordPlaceholder.localizedString, text: $password)
                        .modifier(RoundedTextInput())
                        .focused($passwordInFocus, equals: .plain)
                        .onChange(of: username) { newValue in
                            viewModel.onPasswordChanged(newValue)
                        }
                }
                Button(
                    action: {
                        viewModel.togglePasswordVisibility()
                        passwordInFocus = viewModel.isPasswordHidden ? .secure : .plain
                    },
                    label: {
                        Image(uiImage: .hideText)
                            .frame(
                                width: DesignConstants.InputComponents.thumbnailWidth.cgFloat,
                                height: DesignConstants.InputComponents.thumbnailHeight.cgFloat,
                                alignment: .trailing)
                            .padding(.horizontal, DesignConstants.InputComponents.thumbnailInset.cgFloat)
                    })
            }
            .padding(.horizontal, DesignConstants.Insets.componentsInset.cgFloat)
            Button(
                action: {
                    viewModel.login()
                },
                label: {
                    Text(LocalizedStrings.loginButtonTitle.localizedString)
                        .font(.sourceSansPro(size: DesignConstants.FontSize.regular.cgFloat, weight: .semibold))
                        .foregroundColor(.darkerPurple)
                        .frame(maxWidth: .infinity)
                })
                .modifier(RoundedButton())
                .padding(.horizontal, DesignConstants.Insets.componentsInset.cgFloat)
                .disabled(!viewModel.isLoginButtonEnabled)
            Spacer()
            Spacer()
            Spacer()
        }
        .brandStyleBackground()
    }

}

enum SecureFieldType: Hashable {

    case plain
    case secure

}
