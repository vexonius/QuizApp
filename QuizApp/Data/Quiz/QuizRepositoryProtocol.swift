protocol QuizRepositoryProtocol {

    var quizzes: [QuizRepoModel] { get async throws }

    func getQuizzes(for category: String) async throws -> [QuizRepoModel]

    func getLeaderboard(for quizId: Int)  async throws -> [UserRankingRepoModel]

    func startQuiz(with id: Int) async throws -> QuizSessionRepoModel

    func finishQuiz(for sessionId: String, with result: QuizResultRepoModel) async throws -> QuizSessionResultRepoModel

}
