import SwiftUI

struct ProgressHeader: View {

    var progressText: String
    var progressTiles: [AnsweredResult]
    var currentIndex: Int

    private let tileHeight: CGFloat = 4
    private let progressHorizontalPadding: CGFloat = 20
    private let tileCornerRadius: CGFloat = 2

    var body: some View {
        Text(progressText)
            .font(.sourceSansPro(size: DesignConstants.FontSize.regular.cgFloat, weight: .bold))
            .foregroundColor(.white)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, progressHorizontalPadding)
        HStack(spacing: DesignConstants.Padding.base) {
            ForEach(Array(progressTiles.enumerated()), id: \.offset) { index, item in
                RoundedRectangle(cornerRadius: tileCornerRadius)
                    .fill(setTileColor(for: item, with: index))
                    .frame(maxWidth: .infinity, maxHeight: tileHeight, alignment: .center)
            }
        }
        .padding(.horizontal)
    }

    private func setTileColor(for item: AnsweredResult, with index: Int) -> Color {
        if item == .unanswered {
            return index == currentIndex ? Color.white : Color.white30
        } else {
            return item == .correct ? Color.accentGreen : Color.accentRed
        }
    }

}
