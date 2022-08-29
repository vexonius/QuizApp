import SwiftUI
import Resolver

struct LoginView: View {

    @ObservedObject var viewModel: LoginViewModel

    @State var username: String = ""
    @State var password: String = ""
    @FocusState var passwordInFocus: SecureFieldType?

    var body: some View {
        VStack (spacing: 16) {
            Spacer()
            Text(LocalizedStrings.appName.localizedString)
                .font(.system(size: 32, weight: .bold, design: .default))
                .foregroundColor(Color.white)
            Spacer()
            TextField(
                LocalizedStrings.usernamePlaceholder.localizedString,
                text: $username)
                .modifier(RoundedTextInput())
                .padding([.horizontal], 32)
                .onChange(of: username) { newValue in
                    viewModel.onEmailChanged(username)
                }
            ZStack(alignment: .trailing) {
                if viewModel.isPasswordHidden {
                    SecureField(
                        LocalizedStrings.passwordPlaceholder.localizedString, text: $password)
                    .padding([.vertical], 1) // Secure field seems a tiny bit smaller, therefore you can see a glitch
                    .focused($passwordInFocus, equals: .secure)
                    .modifier(RoundedTextInput())
                    .onChange(of: password) { newValue in
                        viewModel.onPasswordChanged(password)
                    }
                } else {
                    TextField(
                        LocalizedStrings.passwordPlaceholder.localizedString,
                        text: $password)
                        .modifier(RoundedTextInput())
                        .focused($passwordInFocus, equals: .plain)
                        .onChange(of: username) { newValue in
                            viewModel.onPasswordChanged(password)
                        }
                }
                Button(action: {
                        viewModel.togglePasswordVisibility()
                    passwordInFocus = viewModel.isPasswordHidden ? .secure : .plain
                    }, label: {
                        Image(uiImage: .hideText)
                            .frame(width: 20, height: 20, alignment: .trailing)
                            .padding([.horizontal], 20)
                    })
            }
            .padding([.horizontal], 32)
            Button(action: {
                    viewModel.login()
                }, label: {
                    Text(LocalizedStrings.loginButtonTitle.localizedString)
                        .font(.sourceSansPro(size: DesignConstants.FontSize.regular.cgFloat, weight: .semibold))
                        .foregroundColor(.darkerPurple)
                        .frame(maxWidth: .infinity)
                })
                .modifier(RoundedButton())
                .padding([.horizontal], 32)
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
