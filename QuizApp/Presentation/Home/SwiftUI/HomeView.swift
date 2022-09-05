import SwiftUI

struct HomeView: View {

    @ObservedObject private(set) var viewModel: HomeViewModel

    @State var selectedCategory: Int?
    @State private var selected: Int = 0

    private let numberOfPlaceholderItems = 4
    private let horizontalListPadding: CGFloat = 16
    private let segmentedControlHeight: CGFloat = 60

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel

        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = UIColor(.clear)
        UITableView.appearance().backgroundColor = UIColor(.clear)
    }

    var body: some View {
        VStack(spacing: .zero) {
            CategoriesSegmentedControlView(items: viewModel.filters, selectedIndex: $selected)
                .frame(maxHeight: segmentedControlHeight, alignment: .center)
                .onChange(of: selected) { index in
                    viewModel.onCategoryChange(for: index)
                }

            List {
                if viewModel.filteredQuizes.isEmpty {
                    ForEach(0..<numberOfPlaceholderItems) { _ in
                        QuizItemPlaceholderView()
                            .listRowBackground(Color.clear)
                            .listRowInsets(
                                EdgeInsets(
                                    top: .zero,
                                    leading: horizontalListPadding,
                                    bottom: .zero, trailing:
                                        horizontalListPadding))
                    }
                } else {
                    ForEach(viewModel.filteredQuizes, id: \.id) { quiz in
                        QuizItemView(quiz: quiz)
                            .frame(maxWidth: .infinity)
                            .listRowBackground(Color.clear)
                            .listRowInsets(
                                EdgeInsets(
                                    top: .zero,
                                    leading: horizontalListPadding,
                                    bottom: .zero,
                                    trailing: horizontalListPadding))
                    }
                }
            }
            .listStyle(PlainListStyle())
            .modifier(ScrollViewBackgroundModifier())
        }
        .brandStyleBackground()
    }

}
