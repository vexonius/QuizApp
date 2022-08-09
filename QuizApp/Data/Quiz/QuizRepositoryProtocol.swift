protocol QuizRepositoryProtocol {

    var quizes: [QuizRepoModel] { get async throws }

    func getQuizes(for category: String) async throws -> [QuizRepoModel]

}
