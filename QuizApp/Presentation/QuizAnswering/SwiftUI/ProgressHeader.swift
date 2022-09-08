import SwiftUI

struct ProgressHeader: View {

    @Binding var progressText: String
    @Binding var progressTiles: [AnsweredResult]

    private let tileHeight: CGFloat = 4
    private let progressHorizontalPadding: CGFloat = 20
    private let tileSpacing: CGFloat = 8
    private let tileCornerRadius: CGFloat = 2

    var body: some View {
        Text(progressText)
            .font(.sourceSansPro(size: DesignConstants.FontSize.regular.cgFloat, weight: .bold))
            .foregroundColor(.white)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, progressHorizontalPadding)
        HStack(spacing: tileSpacing) {
            ForEach(progressTiles) { item in
                RoundedRectangle(cornerRadius: tileCornerRadius)
                    .fill(Color(uiColor: item == .unanswered ? .whiteTransparent30 : (item == .correct ? .accentGreen : .accentRed)))
                    .frame(maxWidth: .infinity, maxHeight: tileHeight, alignment: .center)
            }
        }
        .padding(.horizontal)
    }

}
