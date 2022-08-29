import SwiftUI

struct SettingsView: View {

    @State var username: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(LocalizedStrings.usernamePlaceholder.localizedString.uppercased())
                .font(.sourceSansPro(size: DesignConstants.FontSize.paragraph.cgFloat, weight: .regular))
                .foregroundColor(.white)
                .padding([.top], 44)
            TextField("", text: $username)
                .font(.sourceSansPro(size: DesignConstants.FontSize.subtitle.cgFloat, weight: .bold))
                .foregroundColor(.white)
            Spacer()
            Button {
                // viewModel.logout()
                } label: {
                    Text(LocalizedStrings.logoutButtonTitle.localizedString)
                        .font(.sourceSansPro(size: DesignConstants.FontSize.regular.cgFloat, weight: .semibold))
                        .foregroundColor(.accentRed)
                        .frame(maxWidth: .infinity)
                }
                .modifier(RoundedButton())
        }
        .padding([.horizontal], DesignConstants.Insets.componentsInset.cgFloat)
        .brandStyleBackground()
    }

}

struct SettingsView_Previews: PreviewProvider {

    static var previews: some View {
        SettingsView()
    }

}
