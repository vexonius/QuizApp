import SwiftUI

struct CategoriesSegmentedControlView: View {

    var items: [CategoryFilter]

    @Binding var selectedIndex: Int
    @Namespace var capsuleAnimation

    private let springAnimationDuration = 0.4

    var body: some View {
        GeometryReader { geometry in
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center) {
                        Spacer()
                        ForEach(items, id: \.index) { filter in
                            Text(filter.title.capitalized)
                                .font(.sourceSansPro(size: DesignConstants.FontSize.subtitle.cgFloat, weight: .bold))
                                .foregroundColor(selectedIndex == filter.index ? filter.category.color : .white30)
                                .padding(.horizontal, DesignConstants.Padding.medium)
                                .padding(.vertical, DesignConstants.Padding.base)
                                .matchedGeometryEffect(
                                    id: filter.index,
                                    in: capsuleAnimation,
                                    isSource: true
                                )
                                .onTapGesture {
                                    withAnimation(.spring(response: springAnimationDuration)) {
                                        selectedIndex = filter.index
                                        proxy.scrollTo(filter.index)
                                    }
                                }
                        }
                        Spacer()
                    }
                    .frame(minWidth: geometry.size.width)
                }
                .padding(DesignConstants.Padding.base)
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
