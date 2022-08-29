import SwiftUI
import Resolver

struct LoginView: View {

    @ObservedObject var viewModel: LoginViewModel
    @State var username: String = ""
    @State var password: String = ""

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
            SecureField(
                LocalizedStrings.passwordPlaceholder.localizedString, text: $password)
                .modifier(RoundedTextInput())
                .padding([.horizontal], 32)
                .onChange(of: password) { newValue in
                    viewModel.onPasswordChanged(password)
                }
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
