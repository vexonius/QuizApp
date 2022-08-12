import Foundation
import UIKit

extension UIImage {

    static let hideText = UIImage(named: "hide-text")!
    static let quiz = UIImage(named: "quiz")!
    static let search = UIImage(named: "search")!
    static let settings = UIImage(named: "settings")!
    static let error = UIImage(named: "error-icon")!
    static let backArrow = UIImage(named: "back-arrow")!
    static let close = UIImage(named: "close")!

    convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        color.set()

        let ctx = UIGraphicsGetCurrentContext()!
        ctx.fill(CGRect(origin: .zero, size: size))

        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        self.init(data: image.pngData()!)!
    }

}
