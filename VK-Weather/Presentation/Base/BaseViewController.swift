import UIKit

enum OrientationLock {
	static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
		if let delegate = UIApplication.shared.delegate as? AppDelegate {
			delegate.orientationLock = orientation
		}
	}
}

class BaseViewController: UIViewController {
	
	// MARK: - Lifecycle methods

	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
	}

	// MARK: - Override

	override func viewWillAppear(_ animated: Bool) {
		OrientationLock.lockOrientation(.portrait)
	}
	
	// MARK: - Public
	
	func showErrorBanner(with message: String) {
		setupErrorBannerView()
		errorBannerView.showMessageBanner(with: message)
	}
	
	func hideErrorBanner() {
		errorBannerView.hideMessageBanner()
		errorBannerView.removeFromSuperview()
	}

	// MARK: - Private

	private let errorBannerView = MessageBannerView(bannerStyle: .error)

	private func setup() {
		view.backgroundColor = .white
	}
	
	private func setupErrorBannerView() {
		view.addSubview(errorBannerView)
		errorBannerView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			errorBannerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			errorBannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
			errorBannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
		])
	}
}
