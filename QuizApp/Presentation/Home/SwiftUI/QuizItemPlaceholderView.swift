import SwiftUI

struct QuizItemPlaceholderView: View {

    let thumbnailSize: CGFloat = 104
    let defaultPadding: CGFloat = 20
    let titleHeight: CGFloat = 24
    let textSpacing: CGFloat = 8
    let horizontalSpacing: CGFloat = 8
    let itemSpacingPadding: CGFloat = 6
    let itemVericalOffset: CGFloat = 10
    let summaryHeight: CGFloat = 16

    var body: some View {
        HStack(alignment: .top, spacing: horizontalSpacing) {
            RoundedRectangle(cornerRadius: DesignConstants.Decorator.cornerSize.cgFloat)
                .foregroundColor(.white30)
                .frame(width: thumbnailSize, height: thumbnailSize, alignment: .topLeading)
            VStack(spacing: textSpacing) {
                RoundedRectangle(cornerRadius: DesignConstants.Decorator.cornerSize.cgFloat)
                    .foregroundColor(.white30)
                    .frame(maxWidth: .infinity, maxHeight: titleHeight, alignment: .topLeading)
                RoundedRectangle(cornerRadius: DesignConstants.Decorator.cornerSize.cgFloat)
                    .foregroundColor(.white30)
                    .frame(maxWidth: .infinity, maxHeight: summaryHeight, alignment: .topLeading)
                RoundedRectangle(cornerRadius: DesignConstants.Decorator.cornerSize.cgFloat)
                    .foregroundColor(.white30)
                    .frame(maxWidth: .infinity, maxHeight: summaryHeight, alignment: .topLeading)
            }
            .offset(x: .zero, y: itemVericalOffset)
        }
        .padding(.all, defaultPadding)
        .background(Color.white30)
        .cornerRadius(DesignConstants.Decorator.cornerSize.cgFloat)
        .frame(maxWidth: .infinity)
        .padding(.vertical, itemSpacingPadding)
    }

    struct QuizItemPlaceholderView_Previews: PreviewProvider {

        static var previews: some View {
            QuizItemPlaceholderView()
        }

    }

}
