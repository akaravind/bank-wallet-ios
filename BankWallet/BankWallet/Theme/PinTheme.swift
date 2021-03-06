import UIKit

class PinTheme {
    static var dotsMargin: CGFloat = 12
    static let infoFontRegular = UIFont.cryptoBody2
    static let infoColor = UIColor.cryptoGray
    static let infoHorizontalMargin: CGFloat = 16
    static let infoVerticalMargin: CGFloat = 16
    static let cancelColor = UIColor.cryptoYellow
    static let cancelSelectedColor = UIColor.cryptoYellowPressed
    static let errorColor = UIColor.cryptoRed

    static let keyboardSideMargin: CGFloat = 17
    static let keyboardHeight: CGFloat = 209
    static let keyboardBottomMargin: CGFloat = 32

    static var lockoutIconBackground: UIColor { return App.shared.localStorage.lightMode ? .white : .cryptoGray50 }
    static let lockoutIconBackgroundSideSize: CGFloat = 94
    static let lockoutLabelTopMargin: CGFloat = 24
    static let lockoutLabelFont = UIFont.cryptoBody2
    static let lockoutLabelColor = UIColor.cryptoGray
    static let lockoutLabelSideMargin: CGFloat = 32

    static let dismissAnimationDuration: Double = 0.3
}
