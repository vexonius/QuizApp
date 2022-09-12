import SwiftUI

struct QuizResultView: View {

    @ObservedObject var viewModel: QuizResultViewModel

    private let labelFontSize: CGFloat = 60

    var body: some View {
        VStack {
            Spacer()
            Text(viewModel.result ?? "")
                .foregroundColor(.white)
                .font(.sourceSansPro(size: labelFontSize, weight: .bold))
            Spacer()
            Button(
                action: viewModel.onFinishButtonTap,
                label: {
                    Text(LocalizedStrings.finishQuiz.localizedString)
                        .foregroundColor(.lightPurple)
                        .font(.sourceSansPro(size: DesignConstants.FontSize.regular.cgFloat, weight: .bold))
                        .frame(maxWidth: .infinity)
                })
                .modifier(RoundedButton())
                .padding(.all, DesignConstants.Padding.large)
        }
        .brandStyleBackground()
    }

}
