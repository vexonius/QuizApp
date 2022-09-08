import SwiftUI

struct HomeView: View {

    @ObservedObject private(set) var viewModel: HomeViewModel

    @State var selectedCategory: Int?

    private let numberOfPlaceholderItems = 4

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel

        styleList()
    }

    var body: some View {
        List {
            if viewModel.filteredQuizzes.isEmpty {
                ForEach(0..<numberOfPlaceholderItems) { _ in
                    QuizItemPlaceholderView()
                        .listRowInsets(EdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
                        .listRowBackground(Color.clear)
                        .transition(.opacity)
                }
            } else {
                ForEach(viewModel.filteredQuizzes, id: \.id) { quiz in
                    QuizItemView(quiz: quiz)
                        .frame(maxWidth: .infinity)
                        .listRowInsets(EdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
                        .listRowBackground(Color.clear)
                        .transition(.opacity)
                }
            }
        }
        .modifier(ScrollViewBackgroundModifier())
        .brandStyleBackground()
        .onAppear(perform: viewModel.observeNetworkChanges)
    }

    private func styleList() {
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = UIColor(.clear)
        UITableView.appearance().backgroundColor = UIColor(.clear)
    }

}
