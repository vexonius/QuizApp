protocol QuizCoordinatorProtocol {

    func routeToQuizDetails(quiz: QuizModel)

    func routeToLeaderBoard(for quizId: Int)

    func routeBackFromLeaderBoard()

}
