import SwiftUI

struct AnswerItem: View {

    @State var answer: AnswerCellModel

    var body: some View {
        Text(answer.answerText)
            .font(.sourceSansPro(size: DesignConstants.FontSize.subtitle.cgFloat, weight: .bold))
            .foregroundColor(.white)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, DesignConstants.Padding.medium)
            .padding(.horizontal, DesignConstants.Padding.large)
            .contentShape(Rectangle())
    }

}
