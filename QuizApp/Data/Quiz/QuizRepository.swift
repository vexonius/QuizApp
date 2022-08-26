import Foundation

class QuizRepository: QuizRepositoryProtocol {

    private var timer: Timer?
    private var task: Task<[QuizRepoModel], Error>?
    private let timerInterval: TimeInterval = 300

    private let quizNetworkClient: QuizNetworkClientProtocol

    init(quizNetworkClient: QuizNetworkClientProtocol) {
        self.quizNetworkClient = quizNetworkClient

        refreshQuizzesPeriodically()
    }

    var quizzes: [QuizRepoModel] {
        get async throws {
            guard let task = task else {
                task = Task {
                    try await quizNetworkClient
                        .quizzes
                        .map { QuizRepoModel(from: $0) }
                }

                return try await task!.value
            }

            return try await task.value
        }
    }

    func getQuizzes(for category: String)  async throws -> [QuizRepoModel] {
        try await quizNetworkClient
            .getQuizzes(for: category)
            .map { QuizRepoModel(from: $0) }
    }

    func refreshQuizzesPeriodically() {
        timer = Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { _ in
            self.task = Task {
                try await self.quizNetworkClient
                    .quizzes
                    .map { QuizRepoModel(from: $0) }
            }
        }
        timer?.fire()
    }

    func getLeaderboard(for quizId: Int)  async throws -> [UserRankingRepoModel] {
        try await quizNetworkClient
            .getLeaderboard(for: quizId)
            .map { UserRankingRepoModel(from: $0) }
    }

    func startQuiz(with id: Int) async throws -> QuizSessionRepoModel {
        let quizQuestionsResponse = try await quizNetworkClient
            .startQuiz(with: id)

        return QuizSessionRepoModel(from: quizQuestionsResponse)
    }

    func finishQuiz(
        for sessionId: String,
        with result: QuizResultRepoModel
    ) async throws -> QuizSessionResultRepoModel {
        let quizSessionResultResponse = try await quizNetworkClient
            .finishQuiz(for: sessionId, with: result.toModel())

        return QuizSessionResultRepoModel(from: quizSessionResultResponse)
    }

}
