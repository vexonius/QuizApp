import Combine
import SwiftUI

struct SettingsView: View {

    @ObservedObject var viewModel: SettingsViewModel

    @State private var username: String = ""

    private let usernameLabelTopOffset: CGFloat = 44
    private let componentsSpacing: CGFloat = 4

    var body: some View {
        VStack(alignment: .leading, spacing: componentsSpacing) {
            Text(LocalizedStrings.usernamePlaceholder.localizedString.uppercased())
                .font(.sourceSansPro(size: DesignConstants.FontSize.paragraph.cgFloat, weight: .regular))
                .foregroundColor(.white)
                .padding([.top], usernameLabelTopOffset)
            TextField(LocalizedStrings.usernamePlaceholder.localizedString, text: $username)
                .font(.sourceSansPro(size: DesignConstants.FontSize.subtitle.cgFloat, weight: .bold))
                .foregroundColor(.white)
                .onSubmit {
                    viewModel.nameOnChange(username)
                }
            Spacer()
            Button(
                action: {
                    viewModel.logout()
                },
                label: {
                    Text(LocalizedStrings.logoutButtonTitle.localizedString)
                        .font(.sourceSansPro(size: DesignConstants.FontSize.regular.cgFloat, weight: .semibold))
                        .foregroundColor(.accentRed)
                        .frame(maxWidth: .infinity)
                })
                .modifier(RoundedButton())
        }
        .padding([.horizontal], DesignConstants.Insets.componentsInset.cgFloat)
        .padding(.bottom, DesignConstants.Insets.componentsInset.cgFloat)
        .brandStyleBackground()
        .onReceive(viewModel.$currentUsername) { username in
            guard let username = username else { return }

            self.username = username
        }
    }

}
