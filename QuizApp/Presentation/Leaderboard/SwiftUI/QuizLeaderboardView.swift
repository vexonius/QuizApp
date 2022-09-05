import SwiftUI

struct QuizLeaderboardView: View {

    @ObservedObject var viewModel: QuizLeaderboardViewModel

    private let itemHeight: CGFloat = 60
    private let numberOfPlaceholderItems = 10

    init(viewModel: QuizLeaderboardViewModel) {
        self.viewModel = viewModel

        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = UIColor(.clear)
        UITableView.appearance().backgroundColor = UIColor(.clear)
        UITableViewCell.appearance().separatorInset = .zero
    }

    var body: some View {
        VStack {
            HStack {
                Text(LocalizedStrings.player.localizedString)
                    .font(.sourceSansPro(size: DesignConstants.FontSize.regular.cgFloat, weight: .semibold))
                    .frame(alignment: .trailing)
                Spacer()
                Text(LocalizedStrings.points.localizedString)
                    .font(.sourceSansPro(size: DesignConstants.FontSize.regular.cgFloat, weight: .semibold))
                    .frame(alignment: .leading)
            }
            .padding(.horizontal, DesignConstants.Padding.medium)
            List {
                if viewModel.userRankings.isEmpty {
                    ForEach(0..<numberOfPlaceholderItems) { _ in
                        RoundedRectangle(cornerRadius: DesignConstants.Decorator.cornerSize.cgFloat)
                            .fill(Color.white30)
                            .frame(maxWidth: .infinity, maxHeight: itemHeight)
                            .listRowBackground(Color.clear)
                            .listRowInsets(
                                EdgeInsets(
                                    top: .zero,
                                    leading: DesignConstants.Padding.medium,
                                    bottom: .zero,
                                    trailing: DesignConstants.Padding.medium))
                            .padding(.vertical, DesignConstants.Padding.base)
                    }
                } else {
                    ForEach(viewModel.userRankings, id: \.position) { item in
                        makeRankItem(with: item)
                            .listRowBackground(Color.clear)
                            .listRowSeparatorTint(.white, edges: .bottom)
                            .listRowInsets(
                                EdgeInsets(
                                    top: .zero,
                                    leading: DesignConstants.Padding.medium,
                                    bottom: .zero,
                                    trailing: DesignConstants.Padding.medium))
                    }
                }
            }
            .listStyle(PlainListStyle())
            .modifier(ScrollViewBackgroundModifier())
        }
        .brandStyleBackground()
        .navigationTitle(LocalizedStrings.appName.localizedString)
    }

    @ViewBuilder
    private func makeRankItem(with model: UserRankingCellModel) -> some View {
        HStack {
            Text(model.position)
                .font(.sourceSansPro(size: DesignConstants.FontSize.subtitle.cgFloat, weight: .bold))
                .lineLimit(.zero)
                .frame(alignment: .leading)
            Text(model.name)
                .font(.sourceSansPro(size: DesignConstants.FontSize.subtitle.cgFloat, weight: .semibold))
                .lineLimit(.zero)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(model.points)
                .font(.sourceSansPro(size: DesignConstants.FontSize.subtitle.cgFloat, weight: .bold))
                .lineLimit(.zero)
                .frame(alignment: .trailing)
        }
        .frame(height: itemHeight)
    }

}
