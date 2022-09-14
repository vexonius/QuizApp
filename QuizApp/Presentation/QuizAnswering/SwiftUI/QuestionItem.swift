import SwiftUI

struct QuestionItem: View {

    @State var question: QuestionCellModel

    private var topPadding: CGFloat = 42

    init(question: QuestionCellModel) {
        self.question = question
    }

    var body: some View {
        Text(question.questionText)
            .font(.sourceSansPro(size: DesignConstants.FontSize.title.cgFloat, weight: .bold))
            .foregroundColor(.white)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, topPadding )
            .padding(.bottom, DesignConstants.Padding.large)
    }

}
