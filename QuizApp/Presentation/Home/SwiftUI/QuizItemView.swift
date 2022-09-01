import SwiftUI

struct QuizItemView: View {

    @State var quiz: QuizCellModel

    let itemHeight: CGFloat = 144
    let thumbnailSize: CGFloat = 104
    let defaultPadding: CGFloat = 20
    let titleTopPadding: CGFloat = 23
    let summaryTopPadding: CGFloat = 4
    let itemSpacingPadding: CGFloat = 10
    let summaryLineLimit = 3

    var body: some View {
        HStack(alignment: .center, spacing: .zero) {
            AsyncImage(
                url: URL(string: quiz.imageUrl),
                content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                },
                placeholder: {
                    Color.white.opacity(0.3)
                })
                .frame(width: thumbnailSize, height: thumbnailSize, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: DesignConstants.Decorator.cornerSize.cgFloat))
                .padding(.horizontal, defaultPadding)
            ZStack(alignment: .topTrailing) {
                VStack(spacing: .zero) {
                    Text(quiz.name)
                        .font(.sourceSansPro(size: DesignConstants.FontSize.title.cgFloat, weight: .bold))
                        .foregroundColor(.white)
                        .lineLimit(.zero)
                        .truncationMode(.tail)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding(.top, titleTopPadding)
                        .padding(.trailing, defaultPadding)
                    Text(quiz.description)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                        .font(.sourceSansPro(size: DesignConstants.FontSize.regular.cgFloat, weight: .semibold))
                        .lineLimit(summaryLineLimit)
                        .truncationMode(.tail)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding(.top, summaryTopPadding)
                        .padding(.trailing, defaultPadding)
                }
                DificultyIndicatorView(difficulty: quiz.difficulty, color: quiz.category.colour)
            }
            .background(.clear)
            .frame(maxHeight: .infinity, alignment: .topTrailing)
        }
        .frame(maxWidth: .infinity, minHeight: itemHeight)
        .background(.white.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: DesignConstants.Decorator.cornerSize.cgFloat))
        .padding(.vertical, itemSpacingPadding)
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
