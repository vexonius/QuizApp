import SwiftUI

struct CategoriesSegmentedControlView: View {

    var items: [CategoryFilter]

    @Binding var selectedIndex: Int
    @Namespace var capsuleAnimation

    private let horizontalPadding: CGFloat = 16
    private let verticalPadding: CGFloat = 8
    private let springAnimationDuration = 0.4

    var body: some View {
        GeometryReader { geometry in
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center) {
                        Spacer()
                        ForEach(items, id: \.index) { category in
                            Text(category.title.capitalized)
                                .font(.sourceSansPro(size: DesignConstants.FontSize.subtitle.cgFloat, weight: .bold))
                                .foregroundColor(
                                    selectedIndex == category.index ?
                                        Color(uiColor: category.tint) :
                                        .white30)
                                .padding(.horizontal, horizontalPadding)
                                .padding(.vertical, verticalPadding)
                                .matchedGeometryEffect(
                                    id: category.index,
                                    in: capsuleAnimation,
                                    isSource: true
                                )
                                .onTapGesture {
                                    withAnimation(.spring(response: springAnimationDuration)) {
                                        selectedIndex = category.index
                                        proxy.scrollTo(category.index)
                                    }
                                }
                        }
                        Spacer()
                    }
                    .frame(minWidth: geometry.size.width)
                }
                .padding(verticalPadding)
                .background {
                    if !items.isEmpty {
                        RoundedRectangle(cornerRadius: DesignConstants.Decorator.cornerSize.cgFloat)
                            .fill(Color.white30)
                            .matchedGeometryEffect(
                                id: selectedIndex,
                                in: capsuleAnimation,
                                isSource: false
                            )
                    }
                }
            }
        }
    }

}
