protocol QuizCoordinatorProtocol {

    func routeToQuizDetails(quiz: QuizModel)

    func routeToLeaderBoard(for quizId: Int)

    func goBack()

    func play(quiz: QuizModel)

    func end(with result: QuizResultModel)

}
