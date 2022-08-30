import SwiftUI
import NukeUI

struct HomeView: View {

    @ObservedObject private(set) var viewModel: HomeViewModel

    @State var selectedCategory: Int?

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel

        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = UIColor(.clear)
        UITableView.appearance().backgroundColor = UIColor(.clear)
     }

    var body: some View {
        VStack {
            List {
                ForEach(viewModel.filteredQuizes, id: \.id) { quiz in
                    QuizItemView(quiz: quiz)
                        .frame(maxWidth: .infinity)
                        .listRowInsets(EdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
                        .listRowBackground(Color.clear)
                }
            }
        }
        .brandStyleBackground()
    }

}
