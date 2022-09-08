import SwiftUI

struct HomeView: View {

    @ObservedObject private(set) var viewModel: HomeViewModel

    @State var selectedCategory: Int?

    private let numberOfPlaceholderItems = 4

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel

        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = UIColor(.clear)
        UITableView.appearance().backgroundColor = UIColor(.clear)
    }

    var body: some View {
        VStack {
            List {
                if viewModel.filteredQuizzes.isEmpty {
                    ForEach(0..<numberOfPlaceholderItems) { _ in
                        QuizItemPlaceholderView()
                            .listRowInsets(EdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
                            .listRowBackground(Color.clear)
                    }
                } else {
                    ForEach(viewModel.filteredQuizzes, id: \.id) { quiz in
                        QuizItemView(quiz: quiz)
                            .frame(maxWidth: .infinity)
                            .listRowInsets(EdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
                            .listRowBackground(Color.clear)
                    }
                }
            }
            .animation(.easeIn)
            .modifier(ScrollViewBackgroundModifier())
        }
        .brandStyleBackground()
    }

}
