import SwiftUI

struct HomeView: View {

    @ObservedObject private(set) var viewModel: HomeViewModel

    @State private var selectedCategory: Int = 0

    private let horizontalListPadding: CGFloat = 16
    private let segmentedControlHeight: CGFloat = 60

    var body: some View {
        VStack(spacing: .zero) {
            CategoriesSegmentedControlView(items: viewModel.filters, selectedIndex: $selectedCategory)
                .frame(maxHeight: segmentedControlHeight, alignment: .center)
                .onChange(of: selectedCategory) { index in
                    viewModel.onCategoryChange(for: index)
                }
            List {
                ForEach(viewModel.filteredQuizzes, id: \.id) { quiz in
                    QuizItemView(quiz: quiz)
                        .frame(maxWidth: .infinity)
                        .listRowInsets(EdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
                        .listRowBackground(Color.clear)
                        .transition(.opacity)
                        .padding(.horizontal, horizontalListPadding)
                }
            }
            .emptyListPlaceholder(view: AnyView(QuizItemPlaceholderView()), visible: viewModel.filteredQuizzes.isEmpty)
            .listStyle(.plain)
            .modifier(ScrollViewBackgroundModifier())
        }
        .brandStyleBackground()
        .onAppear(perform: viewModel.observeNetworkChanges)
    }

}
