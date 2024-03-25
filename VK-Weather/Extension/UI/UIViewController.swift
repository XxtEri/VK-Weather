import UIKit

extension UIViewController {
	func setupActivityIndicator(withBackground: Bool = true) {
		let activityIndicator = ActivityIndicator(withBackground: withBackground)
		view.addSubview(activityIndicator)
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			activityIndicator.topAnchor.constraint(equalTo: view.topAnchor),
			activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
		activityIndicator.setupAnimation()
	}
	
	func stopActivityIndicator() {
		for subview in view.subviews {
			if subview is ActivityIndicator {
				let activityIndicator = subview as! ActivityIndicator
				activityIndicator.stopAnimation()
			}
		}
	}
}
