import Combine
import Foundation

class QuizAnsweringViewModel {

    private struct Constants {
        static let answerUpdateDelay = 0.5
    }

    @Published var currentQuestionCellModels: [AnsweringCellProtocol] = []
    @Published var isTableViewInteractionEnabled: Bool = true
    @Published var correctAnswerIndex: IndexPath?

    private var quizSession: QuizSessionModel?
    private var questions: [QuizQuestionModel] = []
    private var quizUseCase: QuizUseCaseProtocol

    init(quiz: QuizModel, quizUseCase: QuizUseCaseProtocol) {
        self.quizUseCase = quizUseCase

        getQuizSession(with: quiz.id)
    }

    func onCorrectAnswerIndexPathChanged(indexPath: IndexPath) {
        correctAnswerIndex = indexPath
    }

    func onAnswerGuessed(_ answer: AnswerCellModel?) {
        isTableViewInteractionEnabled = false

        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.answerUpdateDelay) {
            self.prepareCurrentAnswerModels()
        }
    }

    private func prepareCurrentAnswerModels() {
        var models: [AnsweringCellProtocol] = []

        guard !questions.isEmpty else {
            finishQuiz()

            return
        }

        let question = questions.removeFirst()

        models.append(QuestionCellModel(from: question))
        models.append(contentsOf: question.answers.map { AnswerCellModel(from: $0) })

        currentQuestionCellModels = models
        isTableViewInteractionEnabled = true
    }

    private func getQuizSession(with id: Int) {
        Task {
            do {
                let quizSession = try await quizUseCase.startQuiz(with: id)

                await MainActor.run {
                    self.quizSession = quizSession
                    self.questions = quizSession.questions
                    self.prepareCurrentAnswerModels()
                }
            } catch {
                debugPrint(error)
            }
        }
    }

    private func finishQuiz() {
        // To be implemented
    }

}
