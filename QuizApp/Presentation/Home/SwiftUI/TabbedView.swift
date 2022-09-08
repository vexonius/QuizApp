import SwiftUI
import Resolver

struct TabbedView: View {

    @ObservedObject var settingsViewModel: SettingsViewModel

    private let tabItemFontSize: CGFloat = 12

    init(settingsViewModel: SettingsViewModel) {
        self.settingsViewModel = settingsViewModel

        styleTabBar()
    }

    var body: some View {
        TabView {
            SettingsView(viewModel: settingsViewModel)
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

    private func styleTabBar() {
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().isTranslucent = false
    }

}
