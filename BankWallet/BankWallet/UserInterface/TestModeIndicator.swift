import UIKit
import SnapKit

class TestModeIndicator {
    private var window: UIWindow?

    init(appConfigProvider: IAppConfigProvider) {
        if appConfigProvider.testMode {
            DispatchQueue.main.async {
                self.show()
            }
        }
    }

    func show() {
        window = UIWindow()
        window?.windowLevel = UIWindowLevelStatusBar + 1
        window?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIApplication.shared.statusBarFrame.height + 5)
        window?.backgroundColor = .clear
        window?.isOpaque = false
        window?.isHidden = false
        window?.isUserInteractionEnabled = false

        let view = UIView()
        view.layer.cornerRadius = 4
        view.backgroundColor = .red

        window?.addSubview(view)
        view.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(80)
            make.bottom.centerX.equalToSuperview()
        }

        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        label.textColor = .white
        label.text = "TESTNET"

        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        window?.layoutIfNeeded()
    }

}
