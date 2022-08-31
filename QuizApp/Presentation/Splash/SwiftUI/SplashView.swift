import SwiftUI
import Resolver

struct SplashView: View {

    @ObservedObject var viewModel: SplashViewModel

    var body: some View {
        EmptyView()
            .brandStyleBackground()
            .onAppear {
                viewModel.validateExistingToken()
            }
    }

}
