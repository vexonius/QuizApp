import SwiftUI

struct QuizDetailsView: View {

    @ObservedObject var viewModel: QuizDetailsViewModel
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    private let descriptionLineLimit = 3
    private let maxHorizontalWidth: CGFloat = 400
    private let coverPadding: CGFloat = 88
    private let maxHeightPercentage = 0.4

    var body: some View {
        GeometryReader { proxy in

            VStack {

                Text(LocalizedStrings.leaderboard.localizedString)
                    .font(.sourceSansPro(size: DesignConstants.FontSize.subtitle.cgFloat, weight: .semibold))
                    .underline(true, color: .white)
                    .padding(.trailing, DesignConstants.Padding.large)
                    .frame(maxWidth: calculateWidth, alignment: .trailing)
                    .onTapGesture(perform: viewModel.onLeaderBoardLabelTap)

                VStack(alignment: .center, spacing: DesignConstants.Padding.medium) {

                    Text(viewModel.quiz.name)
                        .font(.sourceSansPro(size: DesignConstants.FontSize.title.cgFloat, weight: .bold))
                        .foregroundColor(.white)
                        .lineLimit(.zero)
                        .multilineTextAlignment(.center)
                        .truncationMode(.tail)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal, DesignConstants.Padding.large)

                    Text(viewModel.quiz.description)
                        .font(.sourceSansPro(size: DesignConstants.FontSize.subtitle.cgFloat, weight: .semibold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineLimit(descriptionLineLimit)
                        .truncationMode(.tail)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal, DesignConstants.Padding.large)

                    AsyncImage(
                        url: URL(string: viewModel.quiz.imageUrl),
                        content: { image in
                            image
                                .resizable()
                                .scaledToFill()
                        },
                        placeholder: {
                            Color.white30
                        })
                    .frame(
                        maxWidth: proxy.size.width - coverPadding,
                        maxHeight: proxy.size.height * maxHeightPercentage,
                        alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: DesignConstants.Decorator.cornerSize.cgFloat))

                    Button(
                        action: viewModel.onStartQuizButtonTap,
                        label: {
                            buttonLabel
                        })
                    .modifier(RoundedButton())

                }
                .frame(maxWidth: calculateWidth)
                .padding(.all, DesignConstants.Padding.medium)
                .background(backgroundRect)
                .padding(.horizontal, DesignConstants.Padding.medium)

            }
            .frame(width: proxy.size.width, height: proxy.size.height)

        }
        .brandStyleBackground()
        .navigationTitle(LocalizedStrings.appName.localizedString)
    }

}

extension QuizDetailsView {

    private var calculateWidth: CGFloat {
        horizontalSizeClass == .regular ? .infinity : maxHorizontalWidth
    }

    private var backgroundRect: some View {
        RoundedRectangle(cornerRadius: DesignConstants.Decorator.cornerSize.cgFloat)
            .fill(Color.white30)
    }

    private var buttonLabel: some View {
        Text(LocalizedStrings.startQuizTitle.localizedString)
            .font(.sourceSansPro(size: DesignConstants.FontSize.regular.cgFloat, weight: .semibold))
            .frame(maxWidth: .infinity)
    }

}
