import Foundation

class SplashViewModel: ObservableObject {

    private let loginUseCase: LoginUseCaseProtocol
    private let coordinator: AppCoordinatorProtocol

    init(loginUseCase: LoginUseCaseProtocol, coordinator: AppCoordinatorProtocol) {
        self.loginUseCase = loginUseCase
        self.coordinator = coordinator

        validateExistingToken()
    }

    private func validateExistingToken() {
        Task {
            do {
                try await loginUseCase.validateToken()
                await MainActor.run {
                    coordinator.routeToHomeScreen()
                }
            } catch {
                await MainActor.run {
                    coordinator.routeToLogin()
                }
            }
        }
    }

}
