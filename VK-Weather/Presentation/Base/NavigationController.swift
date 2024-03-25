import UIKit

class NavigationController: UINavigationController {
	private var popObservers: [NavigationPopObserver] = []

	init() {
		super.init(nibName: nil, bundle: nil)
		configureDefaultNavigationBarAppearance()
		delegate = self
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	func configureDefaultNavigationBarAppearance() {
		let titleAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white,
															  .font: UIFont.systemFont(ofSize: 16, weight: .bold)]

		let appearance = UINavigationBarAppearance()
		appearance.configureWithTransparentBackground()
		appearance.backgroundColor = .clear
		appearance.shadowColor = .clear
		appearance.titleTextAttributes = titleAttributes
		navigationBar.standardAppearance = appearance
		navigationBar.scrollEdgeAppearance = appearance
		navigationBar.compactScrollEdgeAppearance = appearance

		navigationBar.barTintColor = .white
		navigationBar.isTranslucent = true
		navigationBar.tintColor = .systemBlue
		navigationBar.titleTextAttributes = titleAttributes
		navigationBar.shadowImage = UIImage()
		navigationBar.setBackgroundImage(UIImage(), for: .default)
		view.backgroundColor = .clear
	}

	func addPopObserver(for viewController: UIViewController, coordinator: Coordinator) {
		let observer = NavigationPopObserver(observedViewController: viewController, coordinator: coordinator)
		popObservers.append(observer)
	}

	func removeAllPopObservers() {
		popObservers.removeAll()
	}
}

// MARK: - UINavigationControllerDelegate

extension NavigationController: UINavigationControllerDelegate {
	func navigationController(_ navigationController: UINavigationController,
							  willShow viewController: UIViewController,
							  animated: Bool) {
		navigationController.setNavigationBarHidden(viewController is NavigationBarHiding, animated: animated)
	}
	
	func navigationController(_ navigationController: UINavigationController,
							  didShow viewController: UIViewController,
							  animated: Bool) {
		popObservers.forEach { observer in
			if !navigationController.viewControllers.contains(observer.observedViewController) {
				observer.didObservePop()
				popObservers.removeAll { $0 === observer }
			}
		}
	}
}

// MARK: - UIGestureRecognizerDelegate

extension NavigationController: UIGestureRecognizerDelegate {
	override open func viewDidLoad() {
		super.viewDidLoad()
		interactivePopGestureRecognizer?.delegate = self
	}

	public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
		viewControllers.count > 1
	}
}
