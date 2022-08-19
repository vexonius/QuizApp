import Combine

class QuizResultViewModel {

    @Published var result: String?

    private let resultFormat = "%d / %d"

    private let userResult: QuizResultModel
    private let quizUseCase: QuizUseCaseProtocol
    private let coordinator: QuizCoordinatorProtocol

    init(userResult: QuizResultModel, quizUseCase: QuizUseCaseProtocol, coordinator: QuizCoordinatorProtocol) {
        self.userResult = userResult
        self.coordinator = coordinator
        self.quizUseCase = quizUseCase

        result = String(format: resultFormat, userResult.numberOfCorrectQuestions, userResult.totalNumberOfQuestions)
    }

    private func postResult() {
        Task {
            do {
                _ = try await quizUseCase.endQuiz(with: userResult)
            } catch {
                debugPrint(error)
            }
        }
    }

}
