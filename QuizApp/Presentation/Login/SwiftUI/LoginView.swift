import SwiftUI
import Resolver

struct LoginView: View {

    @State var username: String = ""
    @State var password: String = ""
    @State var isPasswordHidden: Bool = true

    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
        VStack(spacing: DesignConstants.Insets.componentSpacing.cgFloat) {
            Spacer()
            Text(LocalizedStrings.appName.localizedString)
                .font(.system(size: DesignConstants.FontSize.heading.cgFloat, weight: .bold, design: .default))
                .foregroundColor(.white)
            Spacer()
            TextField(LocalizedStrings.usernamePlaceholder.localizedString, text: $username)
                .modifier(RoundedTextInput())
                .onChange(of: username) { username in
                    viewModel.onEmailChanged(username)
                }
            ZStack(alignment: .trailing) {
                SecureField(LocalizedStrings.passwordPlaceholder.localizedString, text: $password)
                    .isTextObuscated($isPasswordHidden, text: $password)
                    .modifier(RoundedTextInput())
                    .onChange(of: password) { password in
                        viewModel.onPasswordChanged(password)
                    }
                Button(
                    action: {
                        viewModel.togglePasswordVisibility()
                    },
                    label: {
                        Image(uiImage: .hideText)
                            .frame(
                                width: DesignConstants.InputComponents.thumbnailWidth.cgFloat,
                                height: DesignConstants.InputComponents.thumbnailHeight.cgFloat,
                                alignment: .trailing)
                            .padding(.horizontal, DesignConstants.Insets.componentsInset.cgFloat)
                    })
            }
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
                .opacity(viewModel.isLoginButtonEnabled ? 1.0 : 0.6)
                .disabled(!viewModel.isLoginButtonEnabled)
            Spacer()
            Spacer()
            Spacer()
        }
        .padding(.horizontal, DesignConstants.Insets.componentsInset.cgFloat)
        .brandStyleBackground()
        .onReceive(viewModel.$isPasswordHidden) { isPasswordHidden in
            self.isPasswordHidden = isPasswordHidden
        }
    }

}
