import SwiftUI

struct DificultyIndicatorView: View {

    @State var difficulty: Difficulty
    @State var color: Color

    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<Difficulty.highest.enumerated) { index in
                RoundedRectangle(cornerRadius: 2)
                    .fill(difficulty.enumerated > index ? color : .white.opacity(0.3))
                    .rotationEffect(Angle(degrees: 45))
                    .frame(width: 10, height: 10, alignment: .topTrailing)
            }
        }
        .padding(.top, 12)
        .padding(.trailing, 16)
    }

}

struct DificultyIndicatorView_Previews: PreviewProvider {

    static var previews: some View {
        DificultyIndicatorView(difficulty: Difficulty(rawValue: "HARD")!, color: .red)
    }

}
