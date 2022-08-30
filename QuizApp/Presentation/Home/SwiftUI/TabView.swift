import SwiftUI
import Resolver

struct TabbedView: View {

    @ObservedObject var settingsViewModel: SettingsViewModel
    @ObservedObject var homeViewModel: HomeViewModel

    private let tabItemFontSize: CGFloat = 12

    init(settingsViewModel: SettingsViewModel, homeViewModel: HomeViewModel) {
        self.settingsViewModel = settingsViewModel
        self.homeViewModel = homeViewModel

        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().isTranslucent = false
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
                .navigationBarTitle(LocalizedStrings.appName.localizedString)
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
