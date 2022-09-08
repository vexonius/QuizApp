import SwiftUI

struct QuizAnsweringView: View {

    @ObservedObject var viewModel: QuizAnsweringViewModel

    @State private var answered: Bool = false
    @State private var selected: Set<AnswerCellModel?> = []

    init(answered: Bool = false, viewModel: QuizAnsweringViewModel) {
        self.answered = answered
        self.viewModel = viewModel

        styleList()
    }

    var body: some View {
        VStack {
            ProgressHeader(progressText: $viewModel.progressText, progressTiles: $viewModel.progress)
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

        let color = answer.isCorrect ? Color(uiColor: .accentGreen) : Color(uiColor: .accentRed)

        return makeAnswerBackgroundView(with: color)
    }

    private func makeAnswerBackgroundView(with color: Color = .white30) -> some View {
        Capsule()
            .fill(color)
            .padding(.horizontal, DesignConstants.Padding.medium)
            .padding(.vertical, DesignConstants.Padding.base)
    }

    private func styleList() {
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = UIColor(.clear)
        UITableView.appearance().backgroundColor = UIColor(.clear)
        UITableViewCell.appearance().separatorInset = .zero
    }

}
