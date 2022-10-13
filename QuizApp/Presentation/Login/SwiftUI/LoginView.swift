import SwiftUI
import Resolver

struct LoginView: View {

    @State var isPasswordHidden: Bool = true

    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
        VStack(spacing: DesignConstants.Insets.componentSpacing.cgFloat) {
            Spacer()
            Text(LocalizedStrings.appName.localizedString)
                .font(.system(size: DesignConstants.FontSize.heading.cgFloat, weight: .bold, design: .default))
                .foregroundColor(.white)
            Spacer()
            TextField(LocalizedStrings.usernamePlaceholder.localizedString, text: $viewModel.email)
                .modifier(RoundedTextInput())
                .onReceive(viewModel.$email, perform: validateInputs)
            toggableSecureFieldButton
            Button(
                action: viewModel.login,
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

extension LoginView {

    var toggableSecureFieldButton: some View {
        ZStack(alignment: .trailing) {
            SecureField(LocalizedStrings.passwordPlaceholder.localizedString, text: $viewModel.password)
                .obfuscateText($viewModel.password, isTextObfuscated: $isPasswordHidden)
                .modifier(RoundedTextInput())
                .onReceive(viewModel.$password, perform: validateInputs)
            Button(
                action: viewModel.togglePasswordVisibility,
                label: {
                    Image(uiImage: .hideText)
                        .frame(
                            width: DesignConstants.InputComponents.thumbnailWidth.cgFloat,
                            height: DesignConstants.InputComponents.thumbnailHeight.cgFloat,
                            alignment: .trailing)
                        .padding(.horizontal, DesignConstants.InputComponents.thumbnailInset.cgFloat)
                })
        }
    }

    private func validateInputs(_: (Published<String>.Publisher.Output)) {
        viewModel.validateInputs()
    }

}
