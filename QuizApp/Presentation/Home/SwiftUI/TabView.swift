import SwiftUI
import Resolver

struct TabbedView: View {

    @ObservedObject var settingsViewModel: SettingsViewModel

    private let tabItemFontSize: CGFloat = 12

    init(settingsViewModel: SettingsViewModel) {
        self.settingsViewModel = settingsViewModel

        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().isTranslucent = false
    }

    var body: some View {
        TabView {
            SettingsView(viewModel: settingsViewModel)
                .font(.sourceSansPro(size: DesignConstants.FontSize.regular.cgFloat, weight: .semibold))
                .tabItem {
                    Image(uiImage: .settings)
                        .foregroundColor(.darkerPurple)
                    Text(LocalizedStrings.settings.localizedString)
                        .font(.sourceSansPro(size: tabItemFontSize, weight: .regular))
                        .foregroundColor(.darkerPurple)
                }
        }
        .accentColor(.lightPurple)
    }

}
