import SwiftUI

struct DificultyIndicatorView: View {

    @State var difficulty: Difficulty
    @State var color: Color

    private let itemSpacingPadding: CGFloat = 10
    private let rectCornerRadius: CGFloat = 2
    private let rectSize: CGFloat = 10
    private let rectRotationAngle: CGFloat = 45
    private let topPadding: CGFloat = 12
    private let trailingPadding: CGFloat = 12

    var body: some View {
        HStack(spacing: itemSpacingPadding) {
            ForEach(0..<Difficulty.highest.enumerated) { index in
                RoundedRectangle(cornerRadius: rectCornerRadius)
                    .fill(difficulty.enumerated > index ? color : .white.opacity(0.3))
                    .rotationEffect(Angle(degrees: rectRotationAngle))
                    .frame(width: rectSize, height: rectSize, alignment: .topTrailing)
            }
        }
        .padding(.top, topPadding)
        .padding(.trailing, trailingPadding)
    }

}

struct DificultyIndicatorView_Previews: PreviewProvider {

    static var previews: some View {
        DificultyIndicatorView(difficulty: Difficulty(rawValue: "HARD")!, color: .red)
    }

}
