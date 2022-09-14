import UIKit

extension SceneDelegate {

    func setPreferredAppUserIntefaceStyle() {
        window?.overrideUserInterfaceStyle = .dark
    }

    func setUITableViewCellStyle() {
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = UIColor.clear
        UITableView.appearance().backgroundColor = UIColor.clear
    }

}
