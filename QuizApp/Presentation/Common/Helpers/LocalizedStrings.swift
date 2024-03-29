import Foundation

enum LocalizedStrings: String {

    case appName = "PopQuiz"

    case emailPlaceholder = "Email"
    case usernamePlaceholder = "Username"
    case passwordPlaceholder = "Password"
    case loginButtonTitle = "Login"
    case logoutButtonTitle = "Logout"

    case quiz = "Quiz"
    case settings = "Settings"

    case error = "Error"
    case networkError = "Network Error"
    case networkErrorDescription = "Data can’t be reached. \nPlease try again"
    case unauthorizedLoginErrorMessage = "Invalid email/password entered. \nPlease try again"
    case serverErrorMessage = "Something went wrong. \n Please try again later"

    case all = "All"
    case startQuizTitle = "Start Quiz"
    case leaderboard = "Leaderboard"
    case player = "Player"
    case points = "Points"
    case finishQuiz = "Finish Quiz"
    case typeHere = "Type here"
    case search = "Search"
    case emptySearchResults = "There are no results for searched term 😣"

    var localizedString: String {
        self.rawValue
    }

}
