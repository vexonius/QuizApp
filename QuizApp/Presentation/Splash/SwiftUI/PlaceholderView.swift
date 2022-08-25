import SwiftUI

struct PlaceholderView: View {

    var body: some View {
        ZStack {
            Color.indigo
            Text(LocalizedStrings.appName.localizedString)
                .font(.system(size: 42, weight: .heavy))
        }
        .navigationTitle(LocalizedStrings.appName.localizedString)
        .ignoresSafeArea()
    }

}

struct PlaceholderView_Previews: PreviewProvider {

    static var previews: some View {
        PlaceholderView()
    }

}
