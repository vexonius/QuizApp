protocol QuizCoordinatorProtocol {

    func routeToQuizDetails(quiz: QuizModel)

    func routeToLeaderBoard(for quizId: Int)

    func goBack()

    func play(quiz: QuizModel)

    func finishQuiz(with result: QuizResultModel)

    func routeToHomeScreen()

}
