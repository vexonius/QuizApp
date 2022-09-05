import Combine

class QuizDetailsViewModel: ObservableObject {

    @Published private(set) var quiz: QuizModel

    private let coordinator: QuizCoordinatorProtocol

    init(quiz: QuizModel, coordinator: QuizCoordinatorProtocol) {
        self.coordinator = coordinator
        self.quiz = quiz
    }

    func onLeaderBoardLabelTap() {
        coordinator.routeToLeaderBoard(for: quiz.id)
    }

    func onStartQuizButtonTap() {
        coordinator.play(quiz: quiz)
    }

}
