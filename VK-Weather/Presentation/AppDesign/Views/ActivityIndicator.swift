import UIKit

final class ActivityIndicator: UIView {

	var withBackground: Bool
	
	init(withBackground: Bool) {
		self.withBackground = withBackground
		super.init(frame: .zero)
		self.alpha = 0.0
		if self.withBackground {
			setupBackground()
		}
		setupIndicator()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	lazy var background: UIView = {
		let background = UIView()
		background.backgroundColor = UIColor.black.withAlphaComponent(0.4)
		return background
	}()
	
	private func setupBackground() {
		addSubview(background)
		background.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			background.topAnchor.constraint(equalTo: topAnchor),
			background.leadingAnchor.constraint(equalTo: leadingAnchor),
			background.trailingAnchor.constraint(equalTo: trailingAnchor),
			background.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
	
	private lazy var indicator: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView(style: .medium)
		indicator.color = .white
		return indicator
	}()
	private func setupIndicator() {
		addSubview(indicator)
		indicator.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			indicator.centerXAnchor.constraint(equalTo: centerXAnchor),
			indicator.centerYAnchor.constraint(equalTo: centerYAnchor)
		])
	}

	func startAnimating() {
		indicator.startAnimating()
		UIView.animate(withDuration: 0.15) {
			self.alpha = 1.0
		}
	}
	
}

extension ActivityIndicator {
	func setupAnimation() {
		self.startAnimating()
	}
	func stopAnimation() {
		indicator.stopAnimating()
		self.alpha = 0.0
		self.removeFromSuperview()
	}
}
