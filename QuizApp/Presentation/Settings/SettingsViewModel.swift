import Foundation

class SettingsViewModel {

    @Published private(set) var currentUsername: String? = ""

    func usernameOnChange(_ newUsername: String) {
        let lastUsername = currentUsername

        guard !newUsername.isEmpty else {
            return currentUsername = lastUsername
        }

        currentUsername = newUsername
    }

}
