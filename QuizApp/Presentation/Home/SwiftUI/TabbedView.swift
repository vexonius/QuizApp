import SwiftUI
import Resolver

struct TabbedView: View {

    @ObservedObject var settingsViewModel: SettingsViewModel
    @ObservedObject var homeViewModel: HomeViewModel

    private let tabItemFontSize: CGFloat = 12

    init(settingsViewModel: SettingsViewModel, homeViewModel: HomeViewModel) {
        self.settingsViewModel = settingsViewModel
        self.homeViewModel = homeViewModel

        styleTabBar()
    }

    var body: some View {
        TabView {
            HomeView(viewModel: homeViewModel)
                .font(.sourceSansPro(size: DesignConstants.FontSize.regular.cgFloat, weight: .semibold))
                .tabItem {
                    Image(uiImage: .quiz)
                        .foregroundColor(.darkerPurple)
                    Text(LocalizedStrings.quiz.localizedString)
                        .font(.sourceSansPro(size: tabItemFontSize, weight: .regular))
                        .foregroundColor(.darkerPurple)
                }
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
        .navigationBarTitle(LocalizedStrings.appName.localizedString)
    }

    private func styleTabBar() {
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().isTranslucent = false
    }

}
