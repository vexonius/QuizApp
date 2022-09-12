import SwiftUI

struct QuizAnsweringView: View {

    @ObservedObject var viewModel: QuizAnsweringViewModel

    @State private var answered: Bool = false
    @State private var selected: Set<AnswerCellModel?> = []

    var body: some View {
        VStack {
            ProgressHeader(
                progressText: viewModel.progressText,
                progressTiles: viewModel.progress,
                currentIndex: viewModel.currentQuestionIndex)
            List {
                ForEach(viewModel.currentQuestionCellModels) { item in
                    switch item {
                    case .question(let question):
                        QuestionItem(question: question)
                            .listRowInsets(EdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
                            .listRowBackground(Color.clear)
                    case .answer(let answer):
                        AnswerItem(answer: answer)
                            .listRowBackground(setAnswerBackgroundView(for: answer))
                            .allowsHitTesting(viewModel.isTableViewInteractionEnabled)
                            .onAppear {
                                if answer.isCorrect {
                                    selected.insert(answer)
                                }
                            }
                            .onTapGesture {
                                selected.insert(answer)
                                answered = true
                                viewModel.onAnswerGuessed(answer)
                            }
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .modifier(ScrollViewBackgroundModifier())
        .onReceive(viewModel.$currentQuestionCellModels) { _ in
            answered = false
            selected = []
        }
        .brandStyleBackground()
        .navigationTitle(LocalizedStrings.appName.localizedString)
    }

}

extension QuizAnsweringView {

    private func setAnswerBackgroundView(for answer: AnswerCellModel) -> some View {
        guard
            answered,
            selected.contains(answer)
        else {
            return makeAnswerBackgroundView()
        }

        let color = answer.isCorrect ? Color.accentGreen : Color.accentRed

        return makeAnswerBackgroundView(with: color)
    }

    private func makeAnswerBackgroundView(with color: Color = .white30) -> some View {
        Capsule()
            .fill(color)
            .padding(.horizontal, DesignConstants.Padding.medium)
            .padding(.vertical, DesignConstants.Padding.base)
    }

}
