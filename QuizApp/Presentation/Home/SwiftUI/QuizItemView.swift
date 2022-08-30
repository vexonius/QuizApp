import SwiftUI
import NukeUI

struct QuizItemView: View {

    @State var quiz: QuizCellModel

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            LazyImage(url: URL(string: quiz.imageUrl))
                .animation(.easeIn)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(width: 104, height: 104, alignment: .leading)
                .padding(.horizontal, 20)
            ZStack(alignment: .topTrailing) {
                VStack(spacing: 0) {
                    Text(quiz.name)
                        .font(.sourceSansPro(size: DesignConstants.FontSize.title.cgFloat, weight: .bold))
                        .foregroundColor(.white)
                        .lineLimit(0)
                        .truncationMode(.tail)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding(.top, 23)
                        .padding(.trailing, 20)
                    Text(quiz.description)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                        .font(.sourceSansPro(size: DesignConstants.FontSize.regular.cgFloat, weight: .semibold))
                        .lineLimit(3)
                        .truncationMode(.tail)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding(.top, 4)
                        .padding(.trailing, 16)
                }
                DificultyIndicatorView(difficulty: quiz.difficulty, color: quiz.category.colour)
            }
            .background(.clear)
            .frame(maxHeight: .infinity, alignment: .topTrailing)
        }
        .frame(maxWidth: .infinity, minHeight: 144)
        .background(.white.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding([.vertical], 10)
    }

}

struct QuizItemView_Previews: PreviewProvider {

    static var previews: some View {
        QuizItemView(
            quiz: QuizCellModel(
                id: 1,
                name: "Bruno",
                description: "Jeste li pravi fan ili ne?",
                category: .uncategorized,
                imageUrl: "https://ca.slack-edge.com/T02JLE4BC-U02CX203Y9M-89c9ad54b4bd-192",
                numberOfQuestions: 5,
                difficulty: .hard))
            .brandStyleBackground()

    }

}
