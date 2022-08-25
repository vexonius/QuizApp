import SwiftUI

struct SplashView: View {

    var body: some View {
        ZStack {
            Color.indigo
            Text(LocalizedStrings.appName.localizedString)
                .font(.system(size: 42, weight: .heavy))
        }
        .brandStyleBackground()
    }

}

struct PlaceholderView_Previews: PreviewProvider {

    static var previews: some View {
        SplashView()
    }

}
